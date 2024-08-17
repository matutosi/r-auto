  # 西暦から和暦への変換
  # 06_18_date-stri-datetime-format.R
c("2019-04-30", "2019-05-01") |>
  ymd() |>
  stringi::stri_datetime_format(format = "Gy年M月d日(E)",
                                locale = "ja_JP@calendar=japanese")

