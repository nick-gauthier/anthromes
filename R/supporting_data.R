# These are several convenience datasets that make it easier to plot and analyze the anthromes data.
# They largely include "keys" to translate between numeric and character representations of anthromes, biomes, and other data,
# as well as color ramps for easy plotting.


# Anthromes
anthrome_key <- tibble(
  anthrome = c(11, 12, 21, 22, 23, 24, 31, 32, 33, 34, 41, 42, 43, 51,
               52, 53, 54, 61, 62, 63, 70),
  class = factor(c('Urban', 'Mixed settlements', 'Rice villages', 'Irrigated villages',
                   'Rainfed villages', 'Pastoral villages', 'Residential irrigated croplands',
                   'Residential rainfed croplands', 'Populated croplands', 'Remote croplands',
                   'Residential rangelands', 'Populated rangelands', 'Remote rangelands',
                   'Residential woodlands', 'Populated woodlands', 'Remote woodlands',
                   'Inhabited drylands', 'Wild woodlands',
                   'Wild drylands', 'Ice', 'NODATA'),
                 levels = c('Urban', 'Mixed settlements', 'Rice villages', 'Irrigated villages',
                            'Rainfed villages', 'Pastoral villages', 'Residential irrigated croplands',
                            'Residential rainfed croplands', 'Populated croplands', 'Remote croplands',
                            'Residential rangelands', 'Populated rangelands', 'Remote rangelands',
                            'Residential woodlands', 'Populated woodlands', 'Remote woodlands',
                            'Inhabited drylands', 'Wild woodlands',
                            'Wild drylands', 'Ice', 'NODATA')),
  level = factor(c('Dense settlements', 'Dense settlements', 'Villages', 'Villages',
                   'Villages', 'Villages', 'Croplands', 'Croplands', 'Croplands', 'Croplands',
                   'Rangelands', 'Rangelands', 'Rangelands', 'Cultured', 'Cultured',
                   'Cultured', 'Cultured', 'Wildlands', 'Wildlands', 'Wildlands', 'NODATA'),
                 levels = c('Dense settlements', 'Villages', 'Croplands',
                            'Rangelands', 'Cultured', 'Wildlands', 'NODATA')),
  type = factor(c('Intensive', 'Intensive', 'Intensive', 'Intensive', 'Intensive', 'Intensive', 'Intensive', 'Intensive', 'Intensive',
                  'Intensive', 'Intensive', 'Intensive', 'Intensive', 'Cultured', 'Cultured','Cultured',
                  'Cultured', 'Wild', 'Wild', 'Wild', 'NODATA'), levels = c('Intensive', 'Cultured', 'Wild', 'NODATA'))
)

#anthrome_class_color <- c('#A80000', '#FF0000', '#0070FF', '#00A9E6', '#A900E6',
#                          '#FF73DF', '#00FFC5', '#E6E600', '#FFFF73', '#FFFFBE',
#                          '#E69800', '#FFD37F', '#FFEBAF', '#38A800', '#A5F57A',
#                          '#D3FFB2', '#B2B2B2', '#DAF2EA', '#E1E1E1', '#FAFFFF', NA) %>%
#  setNames(anthrome_key$class)

anthrome_class_color <- c('#A80000', '#FF0000', '#0070FF', '#00A9E6', '#A900E6',
                          '#FF73DF', '#00FFC5', '#E6E600', '#FFFF73', '#FFFFBE',
                          '#E69800', '#FFD37F', '#FFEBAF', '#38A800', '#A5F57A',
                          '#D3FFB2', '#D9BD75', '#DAF2EA', '#E1E1E1', '#FAFFFF', NA) %>%
  setNames(anthrome_key$class)

anthrome_level_color <- c('Dense settlements' = '#CD6666', 'Villages' = '#AA66CD', 'Croplands' = '#FFFF00',
                          'Rangelands' = '#FFAA00', 'Cultured' = '#D3FFBE', 'Wildlands' = '#38A800', NODATA = NA)

#anthrome_type_color <- c('Intensive' = '#EDCDCB', 'Cultured' = '#FFFFFF', 'Wild' = '#CADAA9', NODATA = NA)
anthrome_type_color <- c('Intensive' = '#EDCDCB', 'Cultured' = '#FFFFFF', 'Wild' = '#CADAA9', NODATA = NA)

anthrome_colors <- c(anthrome_class_color, anthrome_level_color, anthrome_type_color)


# Time steps
time_steps <- c("10000BC", "9000BC", "8000BC", "7000BC", "6000BC", "5000BC", "4000BC", "3000BC", "2000BC", "1000BC", "0AD", "100AD", "200AD", "300AD", "400AD", "500AD", "600AD", "700AD", "800AD", "900AD", "1000AD", "1100AD", "1200AD", "1300AD", "1400AD", "1500AD", "1600AD",  "1700AD",  "1710AD",  "1720AD",  "1730AD",  "1740AD",  "1750AD",  "1760AD", "1770AD", "1780AD", "1790AD", "1800AD", "1810AD", "1820AD", "1830AD", "1840AD", "1850AD", "1860AD", "1870AD", "1880AD", "1890AD", "1900AD", "1910AD", "1920AD", "1930AD", "1940AD", "1950AD", "1960AD", "1970AD", "1980AD", "1990AD", "2000AD", "2001AD", "2002AD", "2003AD", "2004AD", "2005AD", "2006AD", "2007AD", "2008AD", "2009AD", "2010AD", "2011AD", "2012AD", "2013AD", "2014AD", "2015AD", "2016AD", "2017AD")

time_steps_ordered <- factor(time_steps, levels = time_steps, ordered = TRUE)

recent_time_steps <-  c("2012AD",  "2013AD",  "2014AD",  "2015AD",  "2016AD",  "2017AD")

time_steps_millennia <- c("10000BC", "9000BC", "8000BC", "7000BC", "6000BC", "5000BC", "4000BC", "3000BC", "2000BC", "1000BC", "0AD", "1000AD", "2000AD")

time_steps_centuries <- c("0AD", "100AD", "200AD", "300AD", "400AD", "500AD", "600AD", "700AD", "800AD", "900AD", "1000AD", "1100AD", "1200AD", "1300AD", "1400AD", "1500AD", "1600AD",  "1700AD",  "1800AD",  "1900AD", "2000AD")

time_steps_decades <- c("1700AD", "1710AD",  "1720AD",  "1730AD",  "1740AD",  "1750AD",  "1760AD", "1770AD", "1780AD", "1790AD", "1800AD", "1810AD", "1820AD", "1830AD", "1840AD", "1850AD", "1860AD", "1870AD", "1880AD", "1890AD", "1900AD", "1910AD", "1920AD", "1930AD", "1940AD", "1950AD", "1960AD", "1970AD", "1980AD", "1990AD", "2000AD", "2010AD", "2017AD")

time_key <- tibble(time_step = time_steps_ordered,
                   year = c(seq(-10000, -1000, 1000), 1,
                            seq(100, 1700, 100),
                            seq(1710, 2000, 10),
                            seq(2001, 2017, 1)))

period_key <- tibble(time_step = time_steps_ordered) %>%
  mutate(millennia = time_step %in% time_steps_millennia,
         centuries = time_step %in% time_steps_centuries,
         decades = time_step %in% time_steps_decades)

# Biomes
biome_key <- tibble(biome_value = 1:15) %>%
  mutate(biome = case_when(biome_value %in% c(1, 2) ~ 'Tropical woodland',
                           biome_value %in% c(3, 4, 5) ~ 'Temperate woodland',
                           biome_value %in% c(6, 7) ~ 'Boreal woodland',
                           biome_value == 8 ~ 'Mixed woodland',
                           biome_value %in% c(9, 10) ~ 'Grassland and savanna',
                           biome_value %in% c(11, 12) ~ 'Shrubland',
                           biome_value == 13 ~ 'Tundra',
                           biome_value == 14 ~ 'Desert and barren',
                           biome_value == 15 ~ 'Ice, snow'),
         # define levels so plots have correct order
         biome = factor(biome, levels = c('Tropical woodland', 'Temperate woodland', 'Boreal woodland', 'Mixed woodland', 'Grassland and savanna', 'Shrubland', 'Tundra',	'Desert and barren', 'Ice, snow')))

# Regions
region_key <- tibble(region = 1:8, region_name = c('Eurasia', 'Latin America and Caribbean', 'Near East', 'Africa', 'Asia', 'Europe', 'North America', 'Oceania'))
