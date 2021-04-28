#' Helper functions for dealing with HYDE data
#'
#' A set of helper functions for dealing with HYDE data
#' @param hyde_varname The HYDE 3.2 variable name to process.
#' One of 'cropland', 'grazing', 'ir_rice', 'popc', 'tot_irri', 'uopp'
#' @param dgg The discrete global grid file to use for extraction
#' @param hyde_path Path to HYDE 3.2 data
#'
#' @return
#' @export
#'
#' @examples
#' get_hyde_pop(hyde_med, inputs_med, by = 'regions')


# hyde2dgg_stars <- function(var, dgg, path) {
#   # could add check if path is zip or not
#   file.path('/vsizip/', path, paste0(var, '.tif')) %>%
#     raster::stack() %>%
#     {suppressWarnings(raster::brick(.))} %>%
#     exact_extract(dgg, 'sum', append_cols = dgg$geometry, progress = TRUE) %>%
#     rename_with(str_remove, pattern = 'sum.X') %>%
#     st_as_sf() %>%
#     st_as_stars() %>%
#     merge(name = 'time') %>%
#     setNames(var)
# }

# get_hyde_pop2 <- function(hyde, by = NULL) {
#   hyde_pop %>%
#     left_join(an12_dgg_inputs, by = 'ANL12_ID') %>%
#     group_by({{ by }}, time_step) %>%
#     summarise(population = sum(population)) %>%
#     mutate(pop_percent = population / max(population)) %>%
#     ungroup() %>%
#     left_join(time_key, by = 'time_step') %>%
#     filter(!(year %in% c(2001:2009,2011:2016))) %>%
#     mutate(period = case_when(year %in% c(seq(-10000, -1000, 1000), 1) ~ 'Millennia',
#                               year %in% seq(100, 1700, 100) ~ 'Centuries',
#                               year %in% c(seq(1710, 2010, 10), 2017) ~ 'Decades'),
#            period = factor(period, c('Millennia', 'Centuries', 'Decades')))
# }
#
# hyde2dgg <- function(hyde_varname, dgg, hyde_path){
#   suppressWarnings(
#     hyde <- list.files(hyde_path, recursive = TRUE, full.names = TRUE) %>% # does this catch the zip files too? better to unzip here?
#       str_subset(hyde_varname) %>%
#       map(raster) %>%
#       brick() %>%
#       `crs<-`(value = '+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0') %>%
#       exact_extract(dgg, 'sum', progress = TRUE)
#   )
#   time_steps <- names(hyde) %>%
#     str_sub(start = str_length(hyde_varname) + 5) %>%
#     str_remove('_')
#
#   setNames(hyde, time_steps) %>%
#     mutate(ANL12_ID = dgg$ANL12_ID, .before = 1)
# }
