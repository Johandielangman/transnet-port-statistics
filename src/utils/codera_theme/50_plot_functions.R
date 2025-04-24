# A function to help wrap the text in plots
label_wrap <- function(x, l = LINE_WRAP_LENGTH) {
    paste(strwrap(x, l), collapse = "\n")
}

# A function to save a plot in the output directory
gg_codera_save <- function(
    plot,
    name,
    height = DEFAULT_PLOT_SIZE,
    width = DEFAULT_PLOT_SIZE,
    dpi = 400,
    ...
){
    ggsave(
        plot=plot,
        filename=file.path(OUTPUT_PLOTS_DIR, paste0(name, ".png")),
        height=height,
        width=width,
        dpi=dpi,
        ...
    )
}
