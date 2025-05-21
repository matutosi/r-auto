  # 列の縦方向への分割
  # 02_11_analysis-tidyr-separate-longer-delim.R
answer_tidy <- answer_wide |> # data/answer_tidy.csv
  tidyr::separate_longer_delim(apps, delim = ";") |> # ";"で区切り
  tidyr::replace_na(list(apps = "-", comment = ""))  # NAを置換
head(answer_tidy, 3)

