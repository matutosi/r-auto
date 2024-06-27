  # 日付を指定の書式にする関数
  # 04_42_date-format-date-fun.R
format_date <- function(x, out_format = "west"){
  if(out_format == "west"){ # 西暦
    format <- "uuuu年M月d日(E)"
    locale <- NULL
  }
  if(out_format == "jp"){ # 和暦
    format <- "Gy年M月d日(E)"
    locale <- "ja_JP@calendar=japanese"
  }
  x <- stringi::stri_datetime_format(x, format = format, locale = locale)
  return(x)
}

