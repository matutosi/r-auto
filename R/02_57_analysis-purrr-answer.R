  # 集計の繰り返し
  # 02_57_analysis-purrr-answer.R
answer |>
  split_by("area") |>
  purrr::map(count_multi, "apps", ";") |>
  purrr::map(dplyr::arrange, desc(n))

