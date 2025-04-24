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

from pathlib import Path

# =============== // PATH VARIABLES // ===============

ROOT_DIR: Path = Path(__file__).resolve(strict=True).parent
LOG_DIR: Path = ROOT_DIR / "logs"
DOWNLOADS_DIR: Path = ROOT_DIR / "downloads"

# =============== // MAKE DIRECTORIES // ===============

LOG_DIR.mkdir(parents=True, exist_ok=True)
