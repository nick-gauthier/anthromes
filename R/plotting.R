
#'  Anthrome legends
#'
#' Convenience functions to load pre-rendered legends for anthrome plots to use
#' in lieu of those created by ggplot.
#' @return
#' @export
#'
#' @examples
#' anthrome_legend_long()
#' anthrome_legend_wide()
#'
anthrome_legend_long <- function() {
  magick::image_ggplot(magick::image_read(system.file('legends/anthromes_legend_4_vertical_2021_01_18.png')))
}

#' @export
anthrome_legend_wide <- function() {
  magick::image_ggplot(magick::image_read(system.file('legends/anthromes_legend_4_2021_01_18.png', 'anthromes')))
}

# custom function while bug remains in ggplot due to new graphics engine
image_ggplot <- function(image, interpolate = FALSE) { info <- magick::image_info(image)
ggplot2::ggplot(data.frame(x = 0, y = 0), ggplot2::aes_string('x', 'y')) + ggplot2::geom_blank() + ggplot2::theme_void() + ggplot2::coord_fixed(expand = FALSE, xlim = c(0, info$width), ylim = c(0, info$height)) + ggplot2::annotation_raster(image, 0, info$width, info$height, 0, interpolate = interpolate) + NULL
}
