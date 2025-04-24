# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
#
# Author: Johandielangman
# Date: April 2025
#
# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# -----------------// HELPER FUNCTION //-----------------

SCRIPT_DIR = "src"
run_r <- function(filename, path = SCRIPT_DIR){
  source(file.path(path, filename))
}


# -----------------// PIPELINE EXECUTION //-----------------

# ==> SETUP SCRIPTS

run_r("01_library-import.R")
run_r("02_config.R")


# ==> DATA CLEANING
# >>> Add your data cleaning scripts here <<<

# ==> DATA VISUALIZATION
# >>> Add your data visualization scripts here <<<

# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
