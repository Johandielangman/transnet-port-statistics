# ============== // DEFINE THE PALETTE // ==============

codera_color_palette <- c(
  "codera_red" = "#be1e2d",
  "codera_blue" = "#273b8d",
  "codera_grey" = "#737373",
  "codera_light_blue" = "#02acba",
  "codera_teal" = "#018a98",
  "codera_cyan" = "#23bccb",
  "codera_sky" = "#6fd6e2",
  "codera_dark_blue" = "#0e1431",
  "codera_light_grey" = "#c0c5cb",
  "codera_plum" = "#7f3f98",
  "codera_violet" = "#513fbd",
  "codera_pink" = "#d94876",
  "codera_green" = "#4baf4f",
  "codera_lime" = "#a2c935",
  "codera_gold" = "#8d7927",
  "codera_yellow" = "#ffc20e",
  "codera_orange" = "#f7941e",
  "codera_black" = "#000000"
)

# ============== // FUNCTIONS TO FETCH COLOR // ==============

codera_color <- function (color_name) {
  unname(codera_color_palette[color_name])
}

get_codera_colors <- function(...) {
  colors <- c(...)
  if (is.null(colors))
    return (codera_color_palette)
  codera_color_palette[colors]
}
