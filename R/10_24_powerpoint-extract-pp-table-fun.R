  # パワーポイントから表のデータを取り出す関数
  # 10_24_powerpoint-extract-pp-table-fun.R
extract_pp_table <- function(path){
  table <- 
    path |>
    read_pptx() |>
    pptx_summary() |>
    dplyr::filter(content_type == "table cell") |>
    pivotea::pivot(row = "row_id", col = "cell_id", 
                   value = "text", split = c("id", "slide_id"))
  return(table)
}

