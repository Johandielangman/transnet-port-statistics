gglogo <- function(
  logo_path = file.path(RESOURCES_DIR, "logo.png"),
  x_pos_pct = 0.5,
  y_pos_pct = 0.5,
  size = 2,
  dpi = 400,
  transparency = 1 # between 0 and 1
) {
  get_logo_grob <- function(filename, size, dpi, alpha) {
    # Read and scale image
    img <- magick::image_read(filename)
    img <- magick::image_scale(img, paste0(dpi, "x"))

    # Apply transparency
    if (alpha < 1) {
      img <- magick::image_fx(img, expression = paste0("a*", alpha))
    }

    # Convert to raster
    img_raster <- as.raster(img)

    width <- unit(0.1 * size, "npc")
    height <- unit(0.1 * size, "npc")

    grid::rasterGrob(
      img_raster,
      interpolate = TRUE,
      x = unit(x_pos_pct, "npc"),
      y = unit(y_pos_pct, "npc"),
      width = width,
      height = height,
      just = c("center", "center")
    )
  }

  logo_grob <- get_logo_grob(logo_path, size, dpi, transparency)
  annotation_custom(grob = logo_grob)
}
