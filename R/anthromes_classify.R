#' Anthromes classification
#'
#' Applies the Anthromes-12k classification algorithm from Ellis et al. 2020 to a tibble of population
#' and land-use data.
#'
#' @param dat the tibble to apply the anthromes classification to. Must include
#' columns for total population count and areal fractions of urban, rice,
#' irrigation, crops, grazing lands as well as supporting data on potential
#' vegetation and potential village status.
#'
#' @return a tibble containing a new column for the resulting anthrome class
#' @export
#'
#' @references Ellis, E.C., Beusen, A.H. and Goldewijk, K.K., 2020.
#' Anthropogenic biomes: 10,000 BCE to 2015 CE. Land, 9(5), p.129.
#'
#' @examples
#' anthromes_classify(dat)
#'
get_anthromes <- function(hyde, inputs) {
  time_dims <- st_get_dimension_values(hyde, 'time') # get the time values

  seq_along(time_dims) %>% # iterate along the time steps
    # the problem here is that the slice and map approach repeats the geometry vector a bunch of times ... slow!
  map(~anthromes_classify(slice(hyde, 'time', .), inputs)) %>%
  do.call(c, .) %>%
  merge(name = 'time') %>%
  st_set_dimensions('time', time_dims) %>%
  setNames('anthrome') %>%
  mutate(anthrome = recode(anthrome, !!!anthrome_lookup))
}

#' @export
anthromes_classify <- function(dat, inputs){
  # should check that all columns are present
  dat %>%
    `/`(inputs['land_area']) %>% # area_weight
    c(inputs) %>%
    mutate(used = crops + grazing + urban,
           trees = pot_veg <= 8) %>%
  transmute(anthrome = case_when(
    urban >= 0.2 | pop >= 2500 ~ 11L,
    pop >= 100 & pot_vill == FALSE ~ 12L,
    pop >= 100 & rice >= 0.2 ~ 21L,
    pop >= 100 & irrigation >= 0.2 ~ 22L,
    pop >= 100 & crops >= 0.2 ~ 23L,
    pop >= 100 & grazing >= 0.2 ~ 24L,
    pop >= 100 ~ 12L,
    crops >= 0.2 & pop >= 10 & pop < 100 & irrigation >= 0.2 ~ 31L,
    crops >= 0.2 & pop >= 10 & pop < 100 ~ 32L,
    crops >= 0.2 & pop >= 1 & pop < 10 ~ 33L,
    crops >= 0.2 & pop > 0 & pop < 1 ~ 34L,
    grazing >= 0.2 & pop >= 10 & pop < 100 ~ 41L,
    grazing >= 0.2 & pop >= 1 & pop < 10 ~ 42L,
    grazing >= 0.2 & pop > 0 & pop < 1 ~ 43L,
    trees == TRUE & pop >= 10 & pop < 100 ~ 51L,
    trees == TRUE & pop >= 1 & pop < 10 ~ 52L,
    trees == TRUE & pop > 0 & pop < 1 & used < 0.2 ~ 53L,
    trees == TRUE & pop > 0 & pop < 1 & used >= 0.2 & crops >= grazing ~ 34L,
    trees == TRUE & pop > 0 & pop < 1 & used >= 0.2 & crops < grazing ~ 43L,
    pop > 0 & trees == FALSE & used < 0.2 ~ 54L,
    pop > 0 & trees == FALSE & used >= 0.2 & crops >= grazing ~ 34L,
    pop > 0 & trees == FALSE & used >= 0.2 & crops < grazing ~ 43L,
    used >= 0.2 & crops >= 0.2 ~ 34L, # in python code but not paper
    used >= 0.2 & grazing >= 0.2 ~ 43L, # in python code but not paper
    used >= 0.2 & crops >= grazing ~ 34L,
    used >= 0.2 & crops < grazing ~ 43L,
    pot_veg != 15 & trees == TRUE ~ 61L,
    pot_veg != 15 & trees == FALSE ~ 62L,
    pot_veg == 15 & used > 0 ~ 62L, # in python code but not paper
    pot_veg == 15 ~ 63L,
    TRUE ~ 70L)
  )
}

# note removed the area > 0 check for the last 4 classifiers because it was redundant, but it should be in there in case someone inputs a non land area!
