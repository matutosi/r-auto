  # 西暦年と和暦年を変換する関数
  # 04_32_date-convert-yr-fun.R
convert_yr <- function(str, out_format = "west"){
  no_nen <- stringr::str_which(str, "年", negate = TRUE) # "年"無の序数
  str <-
    paste0(str, "-12-31") |>             # 12月31日として処理
    stringr::str_remove("年") |>         # "年"の除去
    date_ish2date() |>
    format_year(out_format = out_format) # 変換
  nen <- rep("年", times = length(str))
  nen[no_nen] <- ""                      # 年の有無に合わせる
  str <- paste0(str, nen)
  return(str)
}
  # 和暦年と西暦年の書式
format_year <- function(x, out_format = "west"){
  if(out_format == "west"){
    format <- "uuuu"
    locale <- NULL
  }
  if(out_format == "jp"){
    format <- "Gy"
    locale <- "ja_JP@calendar=japanese"
  }
  x <- stringi::stri_datetime_format(x, format = format, locale = locale)
  return(x)
}

