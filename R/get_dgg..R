#' Extract raster data with a DGG shapefile
#'
#' @param dat The raster data to extract.
#' @param dgg Shapefile containing the DGG boundaries of to use for the extraction
#' @param var The variable to extract.
#'
#' @return
#' @export
#'
#' @examples dgg_extract(hyde, dgg, 'crops')
dgg_extract <- function(dat, dgg, var) {
  exactextractr::exact_extract(as(dat[var], 'Raster'), dgg, 'sum') %>%
    rename_with(str_remove, pattern = 'sum.X') %>%
    mutate(geometry = dgg$geom) %>%
    st_as_sf() %>%
    st_as_stars() %>%
    merge(name = 'time') %>%
    st_set_dimensions('time', st_get_dimension_values(dat, 'time')) %>%
    setNames(var)
}
