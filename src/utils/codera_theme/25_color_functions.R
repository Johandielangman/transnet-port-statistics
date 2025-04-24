# ============== // HELPER FUNCTIONS // ==============

get_codera_palette <- function(
    palette = "five",
    reverse = FALSE,
    ...
  ) {

  codera_color_palettes <- list(
    two =   get_codera_colors(
      "codera_red",
      "codera_blue"
    ),
    three =  get_codera_colors(
      "codera_red",
      "codera_blue",
      "codera_grey"
    ),
    four = get_codera_colors(
      "codera_red",
      "codera_blue",
      "codera_grey",
      "codera_light_blue"
    ),
    five = get_codera_colors(
      "codera_red",
      "codera_blue",
      "codera_grey",
      "codera_light_blue",
      "codera_dark_blue"
    ),
    six = get_codera_colors(
      "codera_red",
      "codera_blue",
      "codera_grey",
      "codera_light_blue",
      "codera_dark_blue",
      "codera_light_grey"
    ),
    seven = get_codera_colors(
      "codera_red",
      "codera_blue",
      "codera_grey",
      "codera_light_blue",
      "codera_dark_blue",
      "codera_light_grey",
      "codera_purple"
    ),
    eight = get_codera_colors(
      "codera_red",
      "codera_blue",
      "codera_grey",
      "codera_light_blue",
      "codera_dark_blue",
      "codera_light_grey",
      "codera_purple",
      "codera_green"
    ),
    nine = get_codera_colors(
      "codera_red",
      "codera_blue",
      "codera_grey",
      "codera_light_blue",
      "codera_dark_blue",
      "codera_light_grey",
      "codera_purple",
      "codera_green",
      "codera_gold"
    ),
    ten = get_codera_colors(
      "codera_red",
      "codera_blue",
      "codera_grey",
      "codera_light_blue",
      "codera_dark_blue",
      "codera_light_grey",
      "codera_purple",
      "codera_green",
      "codera_gold",
      "codera_orange"
    )
  )

  p <- codera_color_palettes[[palette]]
  if (reverse) p <- rev(p)
  grDevices::colorRampPalette(p, ...)
}

# ============== // GGPLOT SCALE PALETTES // ==============

scale_color_codera <- function(
    palette = "seven",
    discrete = TRUE,
    reverse = FALSE,
    ...
  ) {

  p <- get_codera_palette(
    palette = palette,
    reverse = reverse
  )

  if (discrete) {
    discrete_scale(
      "color", paste0("pilot_", palette), palette = p, ...)
  } else {
    scale_color_gradientn(colors = p(256), ...)
  }
}


scale_fill_codera <- function(
    palette = "ten",
    discrete = TRUE,
    reverse = FALSE,
    ...
  ) {

  p <- get_codera_palette(
    palette = palette,
    reverse = reverse
  )

  if (discrete) {
    discrete_scale(
      "fill", paste0("pilot_", palette), palette = p, ...)
  } else {
    scale_fill_gradientn(colors = p(256), ...)
  }
}
