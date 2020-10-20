
#' Title
#'
#' @param hyde_varname
#' @param hyde_path
#'
#' @return
#' @export
#'
#' @examples
hyde2dgg <- function(hyde_varname, dgg, hyde_path){
  suppressWarnings(
    hyde <- list.files(hyde_path, recursive = TRUE, full.names = TRUE) %>% # does this catch the zip files too? better to unzip here?
      str_subset(hyde_varname) %>%
      map(raster) %>%
      brick %>%
      `crs<-`(value = '+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0') %>%
      exact_extract(dgg, 'sum')
  )
  time_steps <- names(hyde) %>%
    str_sub(start = str_length(hyde_varname) + 5) %>%
    str_remove('_')

  setNames(hyde, time_steps) %>%
    mutate(ANL12_ID = dgg$ANL12_ID, .before = 1)
}
