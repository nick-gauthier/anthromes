#' Title
#'
#' @param predictand
#' @param predictor
#' @param fam
#' @param dat
#'
#' @return
#' @export
#'
#' @examples
calc_aic <- function(predictand, predictor, fam, dat){
  as.formula(paste(predictand, '~', predictor)) %>%
    glm(family = fam, data = dat) %>%
    AIC
}
