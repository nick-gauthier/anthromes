library(RCurl)
library(dplyr)
library(purrr)
library(stringr)

url_hyde <- 'ftp://ftp.pbl.nl/hyde/hyde3.2/baseline/zip/'
url_general <- 'ftp://ftp.pbl.nl/hyde/hyde3.2/general_files/'

destination <- '~/Downloads/HYDE/hyde32_output/'

hyde_names <- str_c('cropland', 'grazing', 'ir_rice', 'popc', 'tot_irri', 'uopp', sep = '|')
recent_years <- str_c(paste0(c(2001:2009,2011:2016), 'AD'), collapse = '|') # include 2010 and 2011 but not other recent years

# if not present in raw-data directory, download land use zip files
get_hyde <- function(url, destination){
  if(!file.exists(paste0(destination, file))){
    temp <- tempfile()
    download.file(url, temp)

    # get a list of the files and find only the variables we care about
    files <- unzip(temp, list = TRUE)$Name %>%
      str_subset(., hyde_names)

    unzip(temp, files = files, exdir = destination,
          overwrite = TRUE)

    unlink(temp)
  }
}

getURL(url_hyde, dirlistonly = TRUE) %>%
  strsplit('\n') %>%
  unlist() %>%
  str_subset(recent_years, negate = TRUE) %>%
  walk(~get_hyde(paste0(url_hyde, .), paste0(destination, .)))

# download supporting files too
getURL(url_general, dirlistonly = TRUE) %>%
  strsplit('\n') %>%
  unlist() %>%
  walk(~download.file(paste0(url_general, .), paste0(destination, .)))

