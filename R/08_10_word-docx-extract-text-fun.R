  # ワードから文字列を抽出する関数
  # 08_10_word-docx-extract-text-fun.R
extract_docx_text <- function(docx, normal = TRUE, heading = TRUE, flatten = TRUE){
  if(sum(normal, heading) == 0){ # 両方ともFALSEのとき
    return("") # ""を返す
  }
  condtion <-  # 検索条件："normal|heading", "normal", "heading" のうち1つ
    c("Normal"[normal], "heading"[heading]) |>
    paste0(collapse = "|")
  text <-      # 文字列
    docx |>
    officer::docx_summary() |>
    dplyr::filter(stringr::str_detect(style_name, condtion)) |>
    dplyr::filter(text != "") |>
    dplyr::select(text)
  if(flatten) text <- text$text
  return(text)
}

