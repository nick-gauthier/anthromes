library(RCurl)
library(dplyr)
library(purrr)
library(stringr)

url_hyde <- 'ftp://ftp.pbl.nl/hyde/hyde3.2/baseline/zip/'
url_general <- 'ftp://ftp.pbl.nl/hyde/hyde3.2/general_files/'

destination <- '~/Downloads/HYDE/hyde32_output/'

hyde_names <- str_c('cropland', 'grazing', 'ir_rice', 'popc', 'tot_irri', 'uopp', sep = '|')
recent_years <- str_c(paste0(2001:2017, 'AD'), collapse = '|')

getURL(url_hyde, dirlistonly = TRUE) %>%
  strsplit('\n') %>%
  unlist() %>%
  str_subset(recent_years, negate = TRUE) %>%
  walk(~get_hyde(paste0(url_hyde, .), paste0(destination, .)))

getURL(url_general, dirlistonly = TRUE) %>%
  strsplit('\n') %>%
  unlist() %>%
  walk(~download.file(paste0(url_general, .), paste0(destination, .)))


# names of the cropland files to extract from the zip files
hyde_file <- paste0('cropland', time_steps, '.asc')


# if not present in raw-data directory, download land use zip files
# and extract only the cropland file to the raw-data directory
get_hyde <- function(url, destination){
#  if(!file.exists(paste0(destination, file))){
    temp <- tempfile()
    download.file(url, temp)

    # get a list of the files and find only the variables we care about
    files <- unzip(temp, list = TRUE)$Name %>%
      str_subset(., hyde_names)

    unzip(temp, files = files, exdir = destination,
          overwrite = TRUE)

    unlink(temp)
 # }
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
