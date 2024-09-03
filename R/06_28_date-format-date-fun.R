  # 日付を指定の書式にする関数
  # 06_28_date-format-date-fun.R
format_date <- function(x, out_format = "west"){
  if(out_format == "west"){ format <- "uuuu年M月d日(E)" } # 西暦
  if(out_format == "jp")  { format <- "Gy年M月d日(E)" }   # 和暦
  locale <- "ja_JP@calendar=japanese"
  x <- stringi::stri_datetime_format(x, format = format, locale = locale)
  return(x)
}

