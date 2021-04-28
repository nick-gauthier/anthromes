#' Supplemental data
#'
#'These are several convenience datasets that make it easier to plot and
#'analyze the anthromes data. They primarily include lookup tables to easily
#'translate between numeric and character representations of anthromes, biomes,
#'and other data, as well as color ramps for easy plotting.
#' @return
#' @export
#'
#' @examples time_steps_centuries()
anthrome_key <- tibble::tibble(
  anthrome = c(
    11, 12, 21, 22, 23, 24, 31, 32, 33, 34,
    41, 42, 43, 51, 52, 53, 54, 61, 62, 63, 70
  ),
  class = factor(
    c(
      'Urban',
      'Mixed settlements',
      'Rice villages',
      'Irrigated villages',
      'Rainfed villages',
      'Pastoral villages',
      'Residential irrigated croplands',
      'Residential rainfed croplands',
      'Populated croplands',
      'Remote croplands',
      'Residential rangelands',
      'Populated rangelands',
      'Remote rangelands',
      'Residential woodlands',
      'Populated woodlands',
      'Remote woodlands',
      'Inhabited drylands',
      'Wild woodlands',
      'Wild drylands',
      'Ice',
      'NODATA'
    ),
    levels = c(
      'Urban',
      'Mixed settlements',
      'Rice villages',
      'Irrigated villages',
      'Rainfed villages',
      'Pastoral villages',
      'Residential irrigated croplands',
      'Residential rainfed croplands',
      'Populated croplands',
      'Remote croplands',
      'Residential rangelands',
      'Populated rangelands',
      'Remote rangelands',
      'Residential woodlands',
      'Populated woodlands',
      'Remote woodlands',
      'Inhabited drylands',
      'Wild woodlands',
      'Wild drylands',
      'Ice',
      'NODATA'
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


# Time steps
time_steps <-
  c("10000BC","9000BC","8000BC","7000BC","6000BC","5000BC","4000BC","3000BC",
    "2000BC","1000BC","0AD","100AD","200AD","300AD","400AD","500AD","600AD",
    "700AD","800AD","900AD","1000AD","1100AD","1200AD","1300AD","1400AD",
    "1500AD","1600AD","1700AD","1710AD","1720AD","1730AD","1740AD","1750AD",
    "1760AD","1770AD","1780AD","1790AD","1800AD","1810AD","1820AD","1830AD",
    "1840AD","1850AD","1860AD","1870AD","1880AD","1890AD","1900AD","1910AD",
    "1920AD","1930AD","1940AD","1950AD","1960AD","1970AD","1980AD","1990AD",
    "2000AD","2001AD","2002AD","2003AD","2004AD","2005AD","2006AD","2007AD",
    "2008AD","2009AD","2010AD","2011AD","2012AD", "2013AD", "2014AD","2015AD",
    "2016AD","2017AD"
  )

time_steps_ordered <- factor(time_steps, levels = time_steps, ordered = TRUE)

recent_time_steps <-  c("2012AD",  "2013AD",  "2014AD",  "2015AD",  "2016AD",  "2017AD")

#' @export
time_steps_millennia <- function() {
  c(
    "10000BC","9000BC","8000BC","7000BC","6000BC","5000BC","4000BC","3000BC",
    "2000BC","1000BC","0AD","1000AD","2000AD"
  )
}

#' @export
time_steps_centuries <- function() {
  c(
    "0AD","100AD","200AD","300AD","400AD","500AD","600AD","700AD","800AD",
    "900AD","1000AD","1100AD","1200AD","1300AD","1400AD","1500AD","1600AD",
    "1700AD","1800AD","1900AD","2000AD"
  )
}

#' @export
time_steps_decades <- function() {
  c(
    "1700AD","1710AD","1720AD","1730AD","1740AD","1750AD","1760AD","1770AD",
    "1780AD","1790AD","1800AD","1810AD","1820AD","1830AD","1840AD","1850AD",
    "1860AD","1870AD","1880AD","1890AD","1900AD","1910AD","1920AD","1930AD",
    "1940AD","1950AD","1960AD","1970AD","1980AD","1990AD","2000AD","2010AD",
    "2017AD"
  )
}


time_key <- tibble::tibble(time_step = time_steps_ordered,
                           year = c(
                             seq(-10000,-1000, 1000),
                             1,
                             seq(100, 1700, 100),
                             seq(1710, 2000, 10),
                             seq(2001, 2017, 1)
                           ))

period_key <- dplyr::mutate(tibble::tibble(time_step = time_steps_ordered),
    millennia = time_step %in% time_steps_millennia(),
    centuries = time_step %in% time_steps_centuries(),
    decades = time_step %in% time_steps_decades()
  )

# Biomes
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
        'Tropical woodland',
        'Temperate woodland',
        'Boreal woodland',
        'Mixed woodland',
        'Grassland and savanna',
        'Shrubland',
        'Tundra',
        'Desert and barren',
        'Ice, snow'
      )
    )
  )

#olson biomes
olson_key <- tibble::tibble(olson_biome = 1:14,
                            olson_name = factor(
                              c(
                                'Tropical & Subtropical Moist Broadleaf Forests',
                                'Tropical & Subtropical Dry Broadleaf Forests',
                                'Tropical & Subtropical Coniferous Forests',
                                'Temperate Broadleaf & Mixed Forests',
                                'Temperate Conifer Forests',
                                'Boreal Forests/Taiga',
                                'Tropical & Subtropical Grasslands, Savannas & Shrublands',
                                'Temperate Grasslands, Savannas & Shrublands',
                                'Flooded Grasslands & Savannas',
                                'Montane Grasslands & Shrublands',
                                'Tundra',
                                'Mediterranean Forests, Woodlands & Scrub',
                                'Deserts & Xeric Shrublands',
                                'Mangroves'
                              ),
                              levels = c(
                                'Tropical & Subtropical Moist Broadleaf Forests',
                                'Tropical & Subtropical Dry Broadleaf Forests',
                                'Tropical & Subtropical Coniferous Forests',
                                'Temperate Broadleaf & Mixed Forests',
                                'Temperate Conifer Forests',
                                'Boreal Forests/Taiga',
                                'Tropical & Subtropical Grasslands, Savannas & Shrublands',
                                'Temperate Grasslands, Savannas & Shrublands',
                                'Flooded Grasslands & Savannas',
                                'Montane Grasslands & Shrublands',
                                'Tundra',
                                'Mediterranean Forests, Woodlands & Scrub',
                                'Deserts & Xeric Shrublands',
                                'Mangroves'
                              )
                            ))

#15-class biomes
biome_key_15 <- dplyr::left_join(
  tibble::tibble(biome_value = 1:15,
                               biome15 = factor(
                                 c(
                                   'Tropical Evergreen Woodland',
                                   'Tropical Deciduous Woodland',
                                   'Temperate Broadleaf and Evergreen Woodland',
                                 'Temperate Needleleaf and Evergreen Woodland',
                                   'Temperate Deciduous Woodland',
                                   'Boreal Evergreen Woodland',
                                   'Boreal Deciduous Woodland',
                                   'Mixed Forest',
                                   'Savanna',
                                   'Grassland and Steppe',
                                   'Dense Shrubland',
                                   'Open Shrubland',
                                   'Tundra',
                                   'Desert and Barren',
                                   'Polar Desert, Rock, and Ice'
                                 ),
                                 levels = c(
                                   'Tropical Evergreen Woodland',
                                   'Tropical Deciduous Woodland',
                                   'Temperate Broadleaf and Evergreen Woodland',
                                  'Temperate Needleleaf and Evergreen Woodland',
                                   'Temperate Deciduous Woodland',
                                   'Boreal Evergreen Woodland',
                                   'Boreal Deciduous Woodland',
                                   'Mixed Forest',
                                   'Savanna',
                                   'Grassland and Steppe',
                                   'Dense Shrubland',
                                   'Open Shrubland',
                                   'Tundra',
                                   'Desert and Barren',
                                   'Polar Desert, Rock, and Ice'
                                 )
                               )), biome_key, by = 'biome_value')

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
