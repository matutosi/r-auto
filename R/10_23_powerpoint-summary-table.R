  # 表のデータ
  # 10_23_powerpoint-summary-table.R
pptx_summary(pp) |>
  dplyr::filter(content_type == "table cell") |>
  dplyr::transmute(id, row_id, cell_id, 
                   text = stringr::str_squish(text)) |> # 余分な空白文字を除去
  tibble::tibble()

