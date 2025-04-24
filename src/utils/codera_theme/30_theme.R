# ============== // THEME // ==============

# A nice tool to use: https://ggplot2tor.com/theme/
theme_codera <- function (
    axes = "",
    grid = "hv",
    caption_position = "right",
    title_family = DEFAULT_FONT_FAMILY,
    subtitle_family = DEFAULT_FONT_FAMILY,
    axis_title_family = DEFAULT_FONT_FAMILY,
    axis_text_family = DEFAULT_FONT_FAMILY,
    legend_title_family = DEFAULT_FONT_FAMILY,
    legend_text_family = DEFAULT_FONT_FAMILY,
    facet_title_family = DEFAULT_FONT_FAMILY,
    caption_family = DEFAULT_FONT_FAMILY,
    title_size = 18,
    subtitle_size = 13,
    axis_title_size = 12,
    axis_text_size = 12,
    legend_title_size = 12,
    legend_text_size = 10,
    facet_title_size = 10,
    caption_size = 9,
    title_color = DEFAULT_TEXT_COLOR,
    subtitle_color = DEFAULT_TEXT_COLOR,
    axis_title_color = DEFAULT_TEXT_COLOR,
    axis_text_color = DEFAULT_TEXT_COLOR,
    legend_title_color = DEFAULT_TEXT_COLOR,
    legend_text_color = DEFAULT_TEXT_COLOR,
    facet_title_color = "#303030",
    caption_color = DEFAULT_TEXT_COLOR,
    background_color = "#f2f1ef",
    axis_line_color = DEFAULT_TEXT_COLOR,
    grid_color = "#d8d8d8",
    ...
  ) {


  # Baseline theme
  theme_codera <- theme(
    aspect.ratio = 1,
    plot.background = element_rect(
      fill = background_color,
      linewidth = 0
    ),
    plot.margin = margin(
      t = 20,
      r = 25,
      b = 20,
      l = 20,
      unit = "pt"
    ),
    plot.title = element_text(
      family = title_family,
      color = title_color,
      face = "bold",
      hjust = 0,
      size = title_size,
      margin = margin(
        t = 0,
        r = 0,
        b = 5,
        l = 0,
        unit = "pt"
      )
    ),
    plot.subtitle = element_text(
      family = subtitle_family,
      color = subtitle_color,
      face = "plain",
      hjust = 0,
      size = subtitle_size,
      margin = margin(
        t = 0,
        r = 0,
        b = 24,
        l = 0,
        unit = "pt"
      )
    ),
    plot.caption = element_text(
      family = caption_family,
      color = caption_color,
      hjust = 0,
      size = caption_size,
      margin = margin(
        t = 10,
        r = 0,
        b = 0,
        l = 0,
        unit = "pt"
      )
    ),
    plot.caption.position = "plot",
    panel.spacing = unit(20, "pt"),
    panel.border = element_blank(),
    panel.background = element_blank(),
    panel.grid = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.line = element_blank(),
    axis.line.x.top = element_blank(),
    axis.line.y.right = element_blank(),
    axis.line.x.bottom = element_blank(),
    axis.line.y.left = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_text(
      family = axis_title_family,
      color = axis_title_color,
      size = axis_title_size),
    axis.title.x = element_text(
      margin = margin(
        t = 12,
        r = 0,
        b = 0,
        l = 0,
        unit = "pt"
      )
    ),
    axis.title.x.top = element_text(
      margin = margin(
        t = 0,
        b = 12,
        unit = "pt"
      )
    ),
    axis.title.y = element_text(
      angle = 90,
      margin = margin(
        t = 0,
        r = 12,
        b = 0,
        l = 0,
        unit = "pt"
      )
    ),
    axis.title.y.right = element_text(
      angle = 90,
      margin = margin(
        r = 0,
        l = 12,
        unit = "pt"
      )
    ),
    axis.text = element_text(
      family = axis_text_family,
      color = axis_text_color,
      size = axis_text_size
    ),
    axis.text.x = element_text(
      margin = margin(
        t = 5,
        r = 0,
        b = 0,
        l = 0,
        unit = "pt"
      )
    ),
    axis.text.x.top = element_text(
      margin = margin(
        t = 0,
        b = 5,
        unit = "pt"
      )
    ),
    axis.text.y = element_text(
      hjust = 1,
      margin = margin(
        t = 0,
        r = 5,
        b = 0,
        l = 0,
        unit = "pt"
      )
    ),
    axis.text.y.right = element_text(
      hjust = 0,
      margin = margin(
        r = 0,
        l = 5,
        unit = "pt"
      )
    ),
    legend.background = element_rect(
      color = NULL,
      fill = background_color,
      linewidth = 0
    ),
    legend.key = element_rect(
      color = background_color,
      fill = background_color
    ),
    legend.title = element_text(
      family = legend_title_family,
      color = legend_title_color,
      face = "bold",
      size = legend_title_size
    ),
    legend.text = element_text(
      family = legend_text_family,
      color = legend_text_color,
      size = legend_text_size
    ),
    strip.background = element_rect(
      color = background_color,
      fill = background_color
    ),
    strip.text = element_text(
      family = facet_title_family,
      color = facet_title_color,
      size = facet_title_size,
      face = "bold"
    )
  )

  # ================= // AXES // =================
  # Now replace as needed

  axis_line <- element_line(
    color = axis_line_color,
    linewidth = 0.3,
    linetype = "solid")

  if (stringr::str_detect(axes, "t")) {
    theme_codera <- theme_codera %+replace%
      theme(
        axis.line.x.top = axis_line,
        axis.ticks.x.top = axis_line)
  }

  if (stringr::str_detect(axes, "r")) {
    theme_codera <- theme_codera %+replace%
      theme(
        axis.line.y.right = axis_line,
        axis.ticks.y.right = axis_line)
  }

  if (stringr::str_detect(axes, "b")) {
    theme_codera <- theme_codera %+replace%
      theme(
        axis.line.x.bottom = axis_line,
        axis.ticks.x.bottom = axis_line)
  }

  if (stringr::str_detect(axes, "l")) {
    theme_codera <- theme_codera %+replace%
      theme(
        axis.line.y.left = axis_line,
        axis.ticks.y.left = axis_line)
  }

  # ================= // GRID LINES // =================
  # Now replace as needed

  grid_line <- element_line(
    color = grid_color,
    linewidth = 0.35,
    linetype = "solid")

  if (stringr::str_detect(grid, "v")) {
    theme_codera <- theme_codera %+replace%
      theme(panel.grid.major.x = grid_line)
  }

  if (stringr::str_detect(grid, "h")) {
    theme_codera <- theme_codera %+replace%
      theme(panel.grid.major.y = grid_line)
  }

  # ================= // OVERWRITE IF THE USER WANTS TO CHANGE ANYTHING! // =================
  theme_codera <- theme_codera %+replace%
    theme(...)

  # ==> RETURN
  theme_codera
}
