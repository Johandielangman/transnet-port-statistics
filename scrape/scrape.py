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

# from pathlib import Path
from typing import (
    Dict,
    Set
)

# =============== // LIBRARY IMPORT // ===============

from loguru import logger

# =============== // MODULE IMPORT // ===============

import constants as c
import transnet as tn

# =============== // INITIAL SETUP // ===============

logger.add(f"{c.LOG_DIR / 'main.log'}")

if __name__ == "__main__":
    logger.info("Starting scrape 🚀")

    crawler: tn.Crawler = tn.Crawler()
    pdf_links: Dict[str, Set[str]] = crawler.crawl()

    for category, links in pdf_links.items():
        crawler.download(
            links=links,
            category=category
        )

    parser: tn.Parser = tn.Parser()
    for category_dir in c.DOWNLOADS_DIR.iterdir():
        for year_dir in category_dir.iterdir():
            for pdf_path in year_dir.iterdir():
                parser.parse(
                    category=category_dir.name,
                    year=year_dir.name,
                    pdf_path=pdf_path
                )
