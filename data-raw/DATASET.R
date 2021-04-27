## code to prepare `DATASET` dataset goes here

library(anthromes)
library(stars)
library(tidyverse)

bbox <- st_bbox(c(xmin = 29, xmax = 39, ymin = 30, ymax = 40), crs = 4326)

eastmed_hyde <- get_hyde() %>%
  st_crop(bbox) %>%
  # current bug in stars loses offset info when filtered
  #filter(time %in% time_steps_millennia()) %>%
  # so subset instead
  .[,,,c(8,9,10,11,21,58)] %>%
  st_as_stars() %>%
  # change the names to something more readable
  setNames(c('crops', 'grazing', 'rice', 'pop', 'irrigation', 'urban'))

usethis::use_data(hyde, overwrite = TRUE)
