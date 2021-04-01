#' Calculate Anthrome trajectories
#'
#' A convenience function to create summaries of the total land area in each
#' anthrome type at each time step, potentially subset by an additional
#' variable.
#'
#' @param data a tibble containing the anthrome classification over time
#' @param by a column in data by which to group the anthrome data before summary
#'
#' @return
#' @export
#'
#' @examples
#' # global summary
#' anthrome_trajectory(dat)
#' # summary by biome
#' anthrome_trajectory(dat, by = 'biome')
anthrome_trajectory <- function(data, by = NULL) {
  data %>%
    left_join(anthrome_key, by = 'anthrome') %>% # join before counting so empty factor levels are preserved
    # this .drop argument turns the ordered time step factor into an unordered factor . . . factor handling could be more consistent
    count(time_step, class, {{ by }}, wt = land_area, name = 'land_area', .drop = FALSE) %>%
    left_join(time_key, by = 'time_step') %>%
    mutate(period = case_when(year %in% c(seq(-10000, -1000, 1000), 1) ~ 'Millennia',
                              year %in% seq(100, 1700, 100) ~ 'Centuries',
                              year %in%  c(seq(1710, 2010, 10), 2017) ~ 'Decades'),
           period = factor(period, c('Millennia', 'Centuries', 'Decades'))) %>%
    group_by(time_step, {{ by }}) %>%
    mutate(percent_land_area = land_area / sum(land_area)) %>%
    ungroup() %>%
    arrange(class, {{ by }}, year) %>%
    select(class, {{ by }}, time_step, percent_land_area, period, year)
}

#' @export
read_anthromes <- function(path) {
  read_csv(path, col_types = cols(.default = 'i')) %>%
    select(-c(`2001AD`:`2009AD`, `2011AD`:`2016AD`)) %>% # remove annual data
    pivot_longer(-id, names_to = 'time_step', values_to = 'anthrome')
}
