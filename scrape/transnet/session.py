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

from urllib3.util.retry import Retry
from contextlib import contextmanager
from typing import (
    Generator
)


# =============== // LIBRARY IMPORT // ===============

from requests.adapters import HTTPAdapter
import requests


@contextmanager
def request_session() -> Generator[requests.Session, None, None]:
    session: requests.Session = requests.Session()
    try:
        # ====> HEADER USING USER AGENT
        session.headers.update({
            "User-Agent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0"
        })

        # ====> RETRY STRATEGY
        retries = Retry(
            total=5,
            backoff_factor=0.3,
            status_forcelist=[500, 502, 503, 504],
            allowed_methods=["HEAD", "GET", "OPTIONS", "POST"]
        )

        # ====> MOUNT
        adapter = HTTPAdapter(max_retries=retries)
        session.mount("http://", adapter)
        session.mount("https://", adapter)

        yield session

    finally:
        session.close()
