#' Title
#'
#' @param dat
#'
#' @return
#' @export
#'
#' @examples
anthromes_classify <- function(dat){
  mutate(dat, anthrome = case_when(
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
    used >= 0.2 & crops >= 0.2 ~ 34L,  # in python code but not paper
    used >= 0.2 & grazing >= 0.2 ~ 43L,  # in python code but not paper
    used >= 0.2 & crops >= grazing ~ 34L,
    used >= 0.2 & crops < grazing ~ 43L,
    pot_veg != 15 & trees == TRUE ~ 61L,
    pot_veg != 15 & trees == FALSE ~ 62L,
    pot_veg == 15 & used > 0 ~ 62L, # in python code but not paper
    pot_veg == 15 ~ 63L,
    TRUE ~ 70L),
    .keep = 'unused'
  )
}

# note removed the area > 0 check for the last 4 classifiers because it was redundant, but it should be in there in case someone inputs a non land area!
