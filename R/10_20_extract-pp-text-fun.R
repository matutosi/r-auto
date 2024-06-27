  # パワーポイントから文字列を取り出す関数
  # 10_20_extract-pp-text-fun.R
extract_pp_text <- function(path){
  paragraph <- 
    path |>
    read_pptx() |>
    pptx_summary() |>
    dplyr::filter(content_type  == "paragraph") |> # 文字列のみ
    dplyr::filter(text != "") |> # 空を除去
    dplyr::select(slide_id, text) # 
  text <- 
    paragraph |>
    dplyr::mutate(dammy = "text") |> # pivot_wider()で使うダミー列
    tidyr::pivot_wider(id_cols = slide_id, # スライドごとに
                       names_from = dammy, 
                       values_from = text, # 文字列を
                       values_fn = list) |> # リストに
    `$`(_, "text") # 文字列を取り出し
  return(text)
}

