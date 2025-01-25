  # 集計の繰り返し
  # 02_45_analysis-purrr-answer.R
group_split(answer, area) |>
  purrr::map(count_multi, "apps", ";") |>
  purrr::map(dplyr::arrange, desc(n))

