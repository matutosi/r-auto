  # 年の有無の判別関数
  # 04_23_date-has-yr-fun.R
has_yr <- function(str){
  dw <- "\\([月火水木金土日祝]+\\)$"
  str <-
    str |>
    stringi::stri_trans_general("fullwidth-halfwidth") |>
    stringr::str_remove(dw) |>                              # 曜日を削除
    stringr::str_remove("日$")                              # 最後の"日"を削除
  res <-
    dplyr::if_else(stringr::str_count(str, "[^0-9]") == 0,  # [^0-9]：数字以外
      dplyr::if_else(stringr::str_count(str, "[0-9]") >= 6, # 数字のみ
              TRUE,                                         # 6桁以上
              FALSE),                                       # 5桁以下
      dplyr::if_else(stringr::str_count(str, "[^0-9]") >= 2, # 数字以外あり
              TRUE,                           # 区切り文字が2つ以上：年あり
              FALSE)                          # 区切り文字が1つ：年なし
    )
  return(res)
}

