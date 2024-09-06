  # 列の縦方向への分割
  # 02_11_analysis-tidyr-separate-longer-delim.R
answer <- answer |>
  tidyr::separate_longer_delim(apps, delim = ";") |> # ";"で区切り
  tidyr::replace_na(list(apps = "-", comment = ""))  # 
head(answer, 3)

