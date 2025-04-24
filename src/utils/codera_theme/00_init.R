# ============== // SETTINGS // ==============

# MUST be loaded for the 'replace' call
library(ggplot2)

DEFAULT_TEXT_COLOR <- "#404040"
LINE_WRAP_LENGTH <- 70  # Characters
DEFAULT_FONT_FAMILY <- "Lato"
DEFAULT_PLOT_SIZE <- 7  # inch

# ============== // SOURCE SCRIPTS // ==============

source(file.path(CODERA_THEME_DIRECTORY, "10_load_fonts.R"))
source(file.path(CODERA_THEME_DIRECTORY, "20_color_palette.R"))
source(file.path(CODERA_THEME_DIRECTORY, "25_color_functions.R"))
source(file.path(CODERA_THEME_DIRECTORY, "30_theme.R"))
source(file.path(CODERA_THEME_DIRECTORY, "40_logo_functions.R"))
source(file.path(CODERA_THEME_DIRECTORY, "50_plot_functions.R"))
