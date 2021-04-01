#' Anthrome color tables
#'
#' Convenience functions for returning color tables for anthrome classes,
#' levels, and types
#' @return
#' @export
#'
#' @examples
#' anthrome_colors('class')
#' anthrome_colors('level')
#' anthrome_colors('type')
anthrome_colors <- function(kind = 'class') {

  if (kind == 'type') {
    c(
      'Intensive' = '#EDCDCB',
      'Cultured' = '#FFFFFF',
      'Wild' = '#CADAA9',
      NODATA = NA
    )
  } else if (kind == 'level') {
    c(
      'Dense settlements' = '#CD6666',
      'Villages' = '#AA66CD',
      'Croplands' = '#FFFF00',
      'Rangelands' = '#FFAA00',
      'Cultured' = '#D3FFBE',
      'Wildlands' = '#38A800',
      NODATA = NA
    )
  } else if (kind == 'class') {
    setNames(
      c('#A80000', '#FF0000', '#0070FF', '#00A9E6', '#A900E6', '#FF73DF',
        '#00FFC5', '#E6E600', '#FFFF73', '#FFFFBE', '#E69800', '#FFD37F',
        '#FFEBAF', '#38A800', '#A5F57A', '#D3FFB2', '#D9BD75', '#DAF2EA',
        '#E1E1E1', '#FAFFFF', NA),
      anthrome_key$class)
  } else {
    stop('Please enter one of "class", "level", or "type"')
  }
}
