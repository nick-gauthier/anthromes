#' Calculate anthrome summaries
#'
#' A convenience function to create summaries of the total land area in each
#' anthrome type at each time step, potentially subset by an additional
#' variable.
#'
#' @param anthromes A stars object containing the anthrome classification.
#' @param hyde A stars object containing HYDE 3.2 land use and population data.
#' @param inputs A stars object containing HYDE 3.2 fixed inputs.
#' @param by a column in data by which to group the anthrome data before summary
#'
#' @return
#' @export
#'
#' @examples
#' # global summary
#' anthrome_summary(anthromes_med, inputs_med)
#' # summary by regions
#' anthrome_summary(anthromes_med, inputs_med, by = regions)
#'
#' # summarise hyde data
#' hyde_summary(hyde_med, inputs_med, by = regions)
anthrome_summary <- function(anthromes, inputs, by = NULL) {
  # join the anthrome data to the supplemental inputs
  merge_inputs(anthromes, inputs) %>%
    count(time, anthrome, {{ by }},
          wt = land_area,
          name = 'land_area') %>%
    group_by(time, {{ by }}) %>%
    mutate(area = units::set_units(land_area / sum(land_area) * 100, '%'),
           .keep = 'unused') %>%
    ungroup() %>%
    tidyr::pivot_wider(id_cols = c({{ by }}, anthrome),
                names_from = time,
                values_from = area,
                # fill NA values with 0
                values_fill = units::set_units(0, '%')) %>%
    arrange({{ by }}, anthrome)
}

#' @export
hyde_summary <- function(hyde, inputs, by = NULL) {
  merge_inputs(hyde, inputs) %>%
   # filter(!is.na({{ by }})) # don't summarize by locations that don't exist
    group_by({{ by }}, time) %>%
    summarise(pop = sum(pop)) %>%
    mutate(pop_percent = units::set_units(pop / max(pop) * 100, '%')) %>%
    ungroup()
}

merge_inputs <- function(dat, inputs) {
  if(is.na(stars::st_raster_type(dat))) {
    left_join(as_tibble(dat),
              as_tibble(inputs),
              by = 'geometry') %>%
      select(-geometry)
  } else {
    # if the data are in raster format, need to round the coordinates to join
    left_join(
      as_tibble(dat) %>%
        filter(!if_any(everything(), is.na)) %>% # remove NA cells
        mutate(x = round(x, 6), y = round(y, 6)),
      as_tibble(inputs) %>% mutate(x = round(x, 6), y = round(y, 6)),
      by = c('x', 'y')) %>%
      select(-x, -y)
  }
}

# if land_area not available,
# could just count the grid cells in each class and give percent of those

#if returning all the dgg shapefiles in long format (replicated for each time)
# is too costly for global analysis, this is an alternative to return cell
# centroids (or alternatively just a spatial index)
#test2 <- st_set_dimensions(anthromes_dgg, 1,
# values=st_centroid(st_dimensions(anthromes_dgg)$geometry$values))

# anthrome_trajectory <- function(data, by = NULL) {
#   data %>%
#     # join before counting so empty factor levels are preserved
#     left_join(anthrome_key, by = 'anthrome') %>%
#     # this .drop argument turns the ordered time step factor into an
#     #unordered factor. factor handling could be more consistent
#     count(time_step, class, {{ by }},
#           wt = land_area, name = 'land_area',
#           .drop = FALSE) %>%
#     left_join(time_key, by = 'time_step') %>%
#     mutate(period =
#              case_when(year %in% c(seq(-10000, -1000, 1000), 1) ~ 'Millennia',
#                               year %in% seq(100, 1700, 100) ~ 'Centuries',
#                           year %in%  c(seq(1710, 2010, 10), 2017) ~ 'Decades'),
#            period = factor(period, c('Millennia', 'Centuries', 'Decades'))) %>%
#     group_by(time_step, {{ by }}) %>%
#     mutate(percent_land_area = land_area / sum(land_area)) %>%
#     ungroup() %>%
#     arrange(class, {{ by }}, year) %>%
#     select(class, {{ by }}, time_step, percent_land_area, period, year)
# }
#
# read_anthromes <- function(path) {
#   read_csv(path, col_types = cols(.default = 'i')) %>%
#     select(-c(`2001AD`:`2009AD`, `2011AD`:`2016AD`)) %>% # remove annual data
#     pivot_longer(-id, names_to = 'time_step', values_to = 'anthrome')
# }
