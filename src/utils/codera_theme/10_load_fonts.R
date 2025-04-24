# ============== // Font Help // ==============
# Download and install font to system: https://fonts.google.com/specimen/Lato
# Honestly, I've had too many problems with other libraries that manages fonts
extrafont::font_import(
  paths=file.path(CODERA_THEME_DIRECTORY, "fonts", "Lato"),
  prompt=FALSE
)
extrafont::loadfonts(device = "win")
