  # パッケージ一覧の取得
  # 15_21_scrape-cran-html-table.R
pkgs <- html_table(html, header = TRUE) |>
  `[[`(_, 1) |> # [[1]]と同じ
  magrittr::set_colnames(c("pkg", "description")) |>
  dplyr::mutate(
    description = stringr::str_replace_all(description, "\n", " "))
pkgs

