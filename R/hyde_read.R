#' Get HYDE 3.2 population and land use data
#'
#' @param vars The HYDE 3.2 variables to import. Either any combination of
#' 'cropland', 'grazing', 'ir_rice', 'popc', 'tot_irri', or 'uopp' for the
#' associated model output, or "inputs" for the HYDE 3.2 fixed inputs variables.
#' @param dir The directory where the compressed HYDE data are. If the file
#' 'raw-data.zip' is not currently in this directory, hyde_download() will
#'  downloaded it from doi:10.7910/DVN/E3H3AK on the Harvard Dataverse.
#'  Defaults to the current working directory.
#'
#' @return A 3-dimensional stars object in 5 arc minute geographic format for
#' all 75 time steps. If vars = 'input', a 2-dimensional stars object.
#' @export
#'
#' @examples \dontrun{
#' hyde_download() # downloads HYDE 3.2 rawdata from Harvard Dataverse
#' hyde_read() # Imports all the time-varying HYDE 3.2 data.
#' hyde_read('inputs') # Imports the HYDE 3.2 fixed inputs
#' }
hyde_read <- function(vars = c('cropland', 'grazing', 'ir_rice', 'popc',
                              'tot_irri', 'uopp'), dir = '.'){
  hyde_dir <- file.path(dir, 'raw-data.zip')

  if(!file.exists(hyde_dir)){stop('Please use hyde_download() to download the
                                  necessary data first.')}

  if(vars == c('inputs')) {
    paste0('/vsizip/vsizip/',
           hyde_dir,
           '/raw-data/supporting_5m_grids.zip/supporting_5m_grids/',
           c('maxln_cr.tif', 'potveg15.tif',
             'simple_regions.tif', 'iso_cr.tif', 'potvill20.tif')
    ) %>%
      stars::read_stars() %>%
      setNames(c('land_area', 'pot_veg', 'regions', 'iso', 'pot_vill')) %>%
      dplyr::mutate(pot_veg =  dplyr::recode(pot_veg, !!!biome_lookup),
             regions =  dplyr::recode(regions, !!!region_lookup))

  } else {
    paste0('/vsizip/vsizip/vsizip/',
           hyde_dir,
           '/raw-data/HYDE.zip/HYDE/',
           vars,
           '.tif.zip/',
           vars, '.tif') %>%
      stars::read_stars() %>%
      stars::st_set_dimensions('band', names = 'time') %>%
      setNames(., gsub('.tif', '', names(.)))
  }
}

#' @describeIn hyde_read Download raw HYDE 3.2 data
#' @export
hyde_download <- function(dir = '.') {
  hyde_dir <- file.path(dir, 'raw-data.zip')

  if(!file.exists(hyde_dir)){
    message('Downloading "raw-data.zip" to ',
            normalizePath(dir),
            ' from Harvard Dataverse.')
    dataverse::get_file('raw-data.zip',
                        dataset = 'doi:10.7910/DVN/E3H3AK',
                        server = 'dataverse.harvard.edu') %>%
      writeBin(hyde_dir)
  } else {
    message('Nothing downloaded, "raw-data.zip" is already present in ',
            normalizePath(dir),'.')
  }
}



# url_hyde <- 'https://dataportaal.pbl.nl/downloads/HYDE/HYDE3.2/'
# url_kk <- https://hs.pangaea.de/model/ALCC/KK10.nc
