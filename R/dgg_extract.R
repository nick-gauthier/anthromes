#' Extract raster data with a DGG shapefile
#'
#' Given a stars data object and shapefile, extracts the relevant data using
#' exactextractr::exact_extract(). Stars inputs should be in raster format with
#' x and y dimensions. This function is planned for deprecation whenever direct
#' support for exact_extract() is better supported via stars::aggregate().
#' @param dat The raster data to extract.
#' @param dgg Shapefile containing the DGG boundaries to use for the extraction.
#' @param var The variable to extract.
#' @param fun The function to pass to exactextractr::exact_extract().
#' @param progress Display the exactextractr::exact_extract() progress bar.
#'
#' @return
#' @export
#'
#' @examples dgg_extract(hyde_med, dgg_med, 'crops', 'sum')
dgg_extract <- function(dat, dgg, var = NULL, fun, progress = FALSE) {
  if(is.null(var)) {
    exactextractr::exact_extract(as(dat, 'Raster'), dgg, fun, progress = progress, force_df = TRUE) %>%
#      rename_with(str_remove, pattern = paste0(fun, '.')) %>%
      dplyr::mutate(geometry = dgg$geom) %>%
      sf::st_as_sf() %>%
      stars::st_as_stars()
  } else {
    exactextractr::exact_extract(as(dat[var], 'Raster'), dgg, fun, progress = progress) %>%
      dplyr::mutate(geometry = dgg$geom) %>%
      sf::st_as_sf() %>%
      stars::st_as_stars() %>%
      merge(name = 'time') %>%
      stars::st_set_dimensions('time',
                               stars::st_get_dimension_values(dat, 'time')) %>%
      setNames(var)
  }
}
