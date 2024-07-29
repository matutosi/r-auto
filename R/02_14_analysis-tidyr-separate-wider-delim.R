  # 列の分割
  # 02_14_analysis-tidyr-separate-wider-delim.R
tidyr::separate_wider_delim(sales, cols = period,
                            delim = "-", names = c("year", "month"), ) |>
  head(3)

