# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
#      /\_/\
#     ( o.o )
#      > ^ <
#
# Author: Johan Hanekom
# Date: April 2025
#
# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# =============== // STANDARD IMPORT // ===============

from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
from urllib.parse import unquote
import re
from typing import (
    Dict,
    Union,
    Iterable,
    Set,
    TYPE_CHECKING
)

# =============== // LIBRARY IMPORT // ===============

from loguru import logger
from bs4 import BeautifulSoup

# =============== // MODULE IMPORT // ===============

import constants as c
from transnet.session import request_session

# =============== // INITIAL SETUP // ===============

logger.add(f"{c.LOG_DIR / 'crawl.log'}")
if TYPE_CHECKING:
    from requests import Response


class Crawler:
    web_root: str = "https://www.transnetnationalportsauthority.net"
    stats_path: str = (
        "/Commercial and Marketing/Pages/Port-Statistics.aspx"
    )
    archive_path: str = (
        "/Commercial and Marketing/Pages/Port-Statistics-Archive.aspx"
    )
    month_variants = {
        'jan': '01_January',
        'january': '01_January',
        'feb': '02_February',
        'february': '02_February',
        'mar': '03_March',
        'march': '03_March',
        'apr': '04_April',
        'april': '04_April',
        'may': '05_May',
        'jun': '06_June',
        'june': '06_June',
        'jul': '07_July',
        'july': '07_July',
        'jully': '07_July',  # custom typo variant
        'aug': '08_August',
        'august': '08_August',
        'sep': '09_September',
        'sept': '09_September',
        'september': '09_September',
        'oct': '10_October',
        'october': '10_October',
        'nov': '11_November',
        'november': '11_November',
        'dec': '12_December',
        'december': '12_December'
    }

    def __init__(self):
        self.month_pattern: str = self.generate_month_pattern()

    def generate_month_pattern(self) -> str:
        return r'\b(' + '|'.join(re.escape(k) for k in self.month_variants.keys()) + r')\b'

    def get_month(self, text: str) -> str:
        text_match: re.Match = re.search(self.month_pattern, text, re.IGNORECASE)
        if text_match:
            month_key: str = text_match.group().lower()
            return self.month_variants[month_key]
        return text

    def crawl(self) -> Dict[str, Set[str]]:
        # TODO: add month filters
        final_links: Dict[str, Set[str]] = {
            "cargo": set(),
            "teu": set(),
            "vessels": set()
        }

        for scraping_path in (self.stats_path, self.archive_path):
            with request_session() as session:
                response: 'Response' = session.get(self.web_root + scraping_path, verify=False)
                response.raise_for_status()

            logger.info(f"Successfully extracted html from {scraping_path}")

            soup: BeautifulSoup = BeautifulSoup(
                response.text,
                "html.parser"
            )

            for link_object in soup.find_all('a'):
                if (link := unquote(link_object.get('href', ''))):
                    if (
                        'pdf' in link and
                        'commercial and marketing' in link.casefold() and
                        'port cargo statistics' in link.casefold()
                    ):
                        pdf_file: str = link.split("/")[-1].casefold()
                        for link_type in final_links.keys():
                            if (
                                (
                                    "year" not in pdf_file and
                                    "calender" not in pdf_file and  # no really :(
                                    "calendar" not in pdf_file
                                ) and
                                link_type in pdf_file
                            ):
                                final_links[link_type].add(self.web_root + link)
                                break

        summary: Dict[str, int] = {k: len(v) for k, v in final_links.items()}
        logger.info(f"Extracted link count per category: {summary}")

        return final_links

    def download(
        self,
        links: Iterable[str],
        category: str,
        dest_dir: Union[str, Path] = c.DOWNLOADS_DIR
    ) -> None:
        n_links: int = len(links)
        if isinstance(dest_dir, str):
            dest_dir: Path = Path(dest_dir)

        dest_dir /= category
        logger.info(f"Starting download of {n_links} link(s) to {dest_dir}")

        def download_link(link: str, index: int) -> None:
            pdf_name: str = link.split('/')[-1]
            year: str = re.search(r'\b\d{4}\b', pdf_name).group()
            file_name: str = f"{year}_" + self.get_month(pdf_name) + f"-{pdf_name}"
            logger.debug(f"[{index + 1}/{n_links}] Downloading {pdf_name}...")

            pdf_dest: Path = dest_dir / year
            pdf_dest.mkdir(parents=True, exist_ok=True)

            pdf_dest_path: Path = pdf_dest / file_name

            try:
                with request_session() as session:
                    response: Response = session.get(link, verify=False)
                    response.raise_for_status()
                    pdf_dest_path.write_bytes(response.content)
            except Exception:
                logger.error(f"Failed to download {pdf_name} - skipping...")

        with ThreadPoolExecutor() as executor:
            executor.map(download_link, links, range(n_links))
