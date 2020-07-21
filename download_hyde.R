library(RCurl)
library(dplyr)
library(purrr)

url <- 'ftp://ftp.pbl.nl/hyde/hyde3.2/baseline/zip/'

destination <- '~/Downloads/HYDE/'

filenames <- getURL(url,dirlistonly = TRUE) %>%
  strsplit('\n') %>%
  unlist()

walk(filenames, ~download.file(paste0(url, .), paste0(destination, .)))


# names of the cropland files to extract from the zip files
hyde_file <- paste0('cropland', time_steps, '.asc')

# if not present in raw-data directory, download land use zip files
# and extract only the cropland file to the raw-data directory
get_hyde <- function(url, file){
  if(!file.exists(paste0('data/raw-data/HYDE/', file))){
    temp <- tempfile()
    download.file(url, temp)
    unzip(temp, files = file, exdir = 'data/raw-data/HYDE',
          overwrite = TRUE)
    unlink(temp)
  }
}

# run get_hyde function on the lists of files above
walk2(.x = hyde_url, .y = hyde_file, .f = get_hyde)

hyde <- list.files('data/raw-data/HYDE', full.names = TRUE) %>%
  .[c(11:8, 3, 1:2, 4:7)] %>% #  temporal order
  map(raster) %>%
  brick %>%
  `crs<-`(value = '+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0')


# # dowload the hyde data
# # which time steps to download
# #time_steps <- c('8000BC', '6000BC', '4000BC', '2000BC', '1000BC', '0AD',
# #                '1000AD', '1500AD', '1750AD', '1850AD', '2000AD')
#
# # url of the land use zip files
# hyde_url <- paste0('ftp://ftp.pbl.nl/hyde/hyde3.2/baseline/zip/',
#                    time_steps, '_lu.zip')
