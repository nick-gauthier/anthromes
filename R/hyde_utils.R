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


get_hyde_pop <- function(hyde, by = NULL) {
  hyde_pop %>%
    left_join(an12_dgg_inputs, by = c('ANL12_ID' = 'id')) %>%
    group_by({{ by }}, time_step) %>%
    summarise(population = sum(population)) %>%
    mutate(pop_percent = population / max(population)) %>%
    ungroup() %>%
    left_join(time_key, by = 'time_step') %>%
    filter(!(year %in% c(2001:2009,2011:2016))) %>%
    mutate(period = case_when(year %in% c(seq(-10000, -1000, 1000), 1) ~ 'Millennia',
                              year %in% seq(100, 1700, 100) ~ 'Centuries',
                              year %in% c(seq(1710, 2010, 10), 2017) ~ 'Decades'),
           period = factor(period, c('Millennia', 'Centuries', 'Decades')))
}
