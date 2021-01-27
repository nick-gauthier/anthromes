read_anthromes <- function(path) {
  read_csv(path, col_types = cols(.default = 'i')) %>%
    select(-c(`2001AD`:`2009AD`, `2011AD`:`2016AD`)) %>% # remove annual data
    pivot_longer(-id, names_to = 'time_step', values_to = 'anthrome')
}
