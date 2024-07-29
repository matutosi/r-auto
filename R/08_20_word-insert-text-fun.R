  # 文字列をまとめて入力する関数
  # 08_20_word-insert-text-fun.R
insert_text <- function(docx, str, style = "Normal"){
  docx <- 
    str |> # strを順番に
    purrr::reduce(officer::body_add_par, style = style, .init = docx)
  return(docx)
}

