#' Extract raster data with a DGG shapefile
#'
#' @param dat The raster data to extract.
#' @param dgg Shapefile containing the DGG boundaries of to use for the extraction
#' @param var The variable to extract.
#'
#' @return
#' @export
#'
#' @examples dgg_extract(hyde_med, dgg_med, 'crops', 'sum')
dgg_extract <- function(dat, dgg, var = NULL, fun) {
  if(is.null(var)) {
    exactextractr::exact_extract(as(dat, 'Raster'), dgg, fun) %>%
#      rename_with(str_remove, pattern = paste0(fun, '.')) %>%
      mutate(geometry = dgg$geom) %>%
      sf::st_as_sf() %>%
      stars::st_as_stars()
  } else {
    exactextractr::exact_extract(as(dat[var], 'Raster'), dgg, fun) %>%
      mutate(geometry = dgg$geom) %>%
      sf::st_as_sf() %>%
      stars::st_as_stars() %>%
      merge(name = 'time') %>%
      stars::st_set_dimensions('time',
                               stars::st_get_dimension_values(dat, 'time')) %>%
      setNames(var)
  }
}
