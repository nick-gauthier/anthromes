#' Supplemental data
#'
#'These are several convenience datasets that make it easier to plot and
#'analyze the anthromes data. They primarily include lookup tables to easily
#'translate between numeric and character representations of anthromes, biomes,
#'and other data, as well as color ramps for easy plotting. The biome data are
#'derived from the 15-class potential natural vegetation dataset of
#'Ramankutty, N. and Foley, J.A., 1999. Estimating historical changes in global
#'land cover: Croplands from 1700 to 1992. Global biogeochemical cycles,
#'13(4), pp.997-1027, along with a simplification using only 9 classes.
#' @return
#' @export
#'
#' @examples time_steps_millennia
#' @examples time_steps_centuries
#' @examples time_steps_years
#' @examples time_steps
anthrome_key <- tibble::tibble(
  anthrome = c(
    11, 12, 21, 22, 23, 24, 31, 32, 33, 34,
    41, 42, 43, 51, 52, 53, 54, 61, 62, 63, 70
  ),
  class = factor(
    c(
      'Urban', 'Mixed settlements', 'Rice villages', 'Irrigated villages',
      'Rainfed villages','Pastoral villages','Residential irrigated croplands',
      'Residential rainfed croplands','Populated croplands','Remote croplands',
      'Residential rangelands','Populated rangelands','Remote rangelands',
      'Residential woodlands','Populated woodlands','Remote woodlands',
      'Inhabited drylands','Wild woodlands', 'Wild drylands', 'Ice','NODATA'
    ),
    levels = c(
      'Urban', 'Mixed settlements', 'Rice villages', 'Irrigated villages',
      'Rainfed villages','Pastoral villages','Residential irrigated croplands',
      'Residential rainfed croplands','Populated croplands','Remote croplands',
      'Residential rangelands','Populated rangelands','Remote rangelands',
      'Residential woodlands','Populated woodlands','Remote woodlands',
      'Inhabited drylands','Wild woodlands', 'Wild drylands', 'Ice','NODATA'
    )
  ),
  level = factor(
    c(
      rep('Dense settlements', 2),
      rep('Villages', 4),
      rep('Croplands', 4),
      rep('Rangelands', 3),
      rep('Cultured', 4),
      rep('Wildlands', 3),
      'NODATA'
    ),
    levels = c(
      'Dense settlements',
      'Villages',
      'Croplands',
      'Rangelands',
      'Cultured',
      'Wildlands',
      'NODATA'
    )
  ),
  type = factor(
    c(
      rep('Intensive', 13),
      rep('Cultured', 4),
      rep('Wild', 3),
      'NODATA'
    ),
    levels = c('Intensive', 'Cultured', 'Wild', 'NODATA')
  )
)
#' @export
anthrome_lookup <- anthrome_key %>%
  dplyr::pull(class) %>%
  setNames(anthrome_key$anthrome)

#' @export
anthrome_class_to_type <- anthrome_key %>%
  dplyr::pull(type) %>%
  setNames(anthrome_key$class)

# Time steps

#' @export
time_steps_millennia <- c(paste0(seq(10000, 1000, -1000), 'BC'),
                          paste0(seq(0, 2000, 1000), 'AD'))

#' @export
time_steps_centuries <- paste0(seq(0, 2000, 100), 'AD')

#' @export
time_steps_decades <- paste0(c(seq(1700, 2010, 10), 2017), 'AD') # note 2017

#' @export
time_steps_years <- paste0(2000:2017, 'AD')

#' @export
time_steps <- c(time_steps_millennia[1:10],
                time_steps_centuries[1:17],
                time_steps_decades[1:30],
                time_steps_years)

# Biomes
#' @export
biome_key <- dplyr::mutate(tibble::tibble(biome_value = 1:15),
    biome = dplyr::case_when(
      biome_value %in% c(1, 2) ~ 'Tropical woodland',
      biome_value %in% c(3, 4, 5) ~ 'Temperate woodland',
      biome_value %in% c(6, 7) ~ 'Boreal woodland',
      biome_value == 8 ~ 'Mixed woodland',
      biome_value %in% c(9, 10) ~ 'Grassland and savanna',
      biome_value %in% c(11, 12) ~ 'Shrubland',
      biome_value == 13 ~ 'Tundra',
      biome_value == 14 ~ 'Desert and barren',
      biome_value == 15 ~ 'Ice, snow'
    ),
    # define levels so plots have correct order
    biome = factor(
      biome,
      levels = c(
        'Tropical woodland','Temperate woodland','Boreal woodland',
        'Mixed woodland','Grassland and savanna','Shrubland','Tundra',
        'Desert and barren','Ice, snow'
      )
    ),
    biome15 = factor(
      c(
        'Tropical Evergreen Woodland','Tropical Deciduous Woodland',
        'Temperate Broadleaf and Evergreen Woodland',
        'Temperate Needleleaf and Evergreen Woodland',
        'Temperate Deciduous Woodland','Boreal Evergreen Woodland',
        'Boreal Deciduous Woodland','Mixed Forest','Savanna',
        'Grassland and Steppe','Dense Shrubland','Open Shrubland','Tundra',
        'Desert and Barren','Polar Desert, Rock, and Ice'
      ),
      levels = c(
        'Tropical Evergreen Woodland','Tropical Deciduous Woodland',
        'Temperate Broadleaf and Evergreen Woodland',
        'Temperate Needleleaf and Evergreen Woodland',
        'Temperate Deciduous Woodland','Boreal Evergreen Woodland',
        'Boreal Deciduous Woodland','Mixed Forest','Savanna',
        'Grassland and Steppe','Dense Shrubland','Open Shrubland','Tundra',
        'Desert and Barren','Polar Desert, Rock, and Ice'
      )
    )
  )

#' @export
biome_lookup <- biome_key %>%
  dplyr::pull(biome15) %>%
  setNames(biome_key$biome_value)

# Regions
region_key <-
  tibble::tibble(
    region = 1:8,
    region_name = c(
      'Eurasia',
      'Latin America and Caribbean',
      'Near East',
      'Africa',
      'Asia',
      'Europe',
      'North America',
      'Oceania'
    )
  )

region_lookup <- setNames(as.factor(region_key$region_name), region_key$region)
