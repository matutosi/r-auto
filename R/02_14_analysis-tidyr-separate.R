  # 列の分割
  # 02_14_analysis-tidyr-separate.R
tidyr::separate(sales, col = period, into = c("year", "month"), sep = "-") |>
  head(3)

