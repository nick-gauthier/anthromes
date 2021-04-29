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
    dplyr::count(time, anthrome, {{ by }},
          wt = land_area,
          name = 'land_area') %>%
    dplyr::group_by(time, {{ by }}) %>%
    dplyr::mutate(area = units::set_units(land_area / sum(land_area) * 100,'%'),
           .keep = 'unused') %>%
    dplyr::ungroup() %>%
    tidyr::pivot_wider(id_cols = c({{ by }}, anthrome),
                names_from = time,
                values_from = area,
                # fill NA values with 0
                values_fill = units::set_units(0, '%')) %>%
    dplyr::arrange({{ by }}, anthrome)
}

#' @describeIn anthrome_summary Summarise HYDE 3.2 population time series.
#' @export
hyde_summary <- function(hyde, inputs, by = NULL) {
  merge_inputs(hyde, inputs) %>%
   # filter(!is.na({{ by }})) # don't summarize by locations that don't exist
    dplyr::group_by({{ by }}, time) %>%
    dplyr::summarise(pop = sum(pop)) %>%
    dplyr::mutate(pop_percent = units::set_units(pop / max(pop) * 100, '%')) %>%
    dplyr::ungroup()
}

merge_inputs <- function(dat, inputs) {
  if(is.na(stars::st_raster_type(dat))) {
    dplyr::left_join(as_tibble(dat),
              as_tibble(inputs),
              by = 'geometry') %>%
      dplyr::select(-geometry)
  } else {
    # if the data are in raster format, need to round the coordinates to join
    dplyr::left_join(
      dplyr::as_tibble(dat) %>%
        dplyr::filter(!dplyr::if_any(everything(), is.na)) %>% # remove NA cells
        dplyr::mutate(x = round(x, 6), y = round(y, 6)),
      dplyr::as_tibble(inputs) %>%
        dplyr::mutate(x = round(x, 6), y = round(y, 6)),
      by = c('x', 'y')) %>%
      dplyr::select(-x, -y)
  }
}

# if land_area not available,
# could just count the grid cells in each class and give percent of those

#if returning all the dgg shapefiles in long format (replicated for each time)
# is too costly for global analysis, this is an alternative to return cell
# centroids (or alternatively just a spatial index)
#test2 <- st_set_dimensions(anthromes_dgg, 1,
# values=st_centroid(st_dimensions(anthromes_dgg)$geometry$values))
