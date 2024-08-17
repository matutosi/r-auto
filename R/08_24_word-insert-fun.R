  # 文字列や画像をまとめて入力する関数
  # 08_24_word-insert-fun.R
insert_texts <- function(docx, str, style = "Normal", ...){
  purrr::reduce(str, officer::body_add_par, 
                style = style, .init = docx, ...)
}
insert_images <- function(docx, images, width = 3, height = NULL, ...){
  size <- magick::image_read(images) |>
    magick::image_info() |> `[`(_, c("width", "height"))
  if(is.null(height)) height <- width * (size[[2]] / size[[1]])
  purrr::reduce(images, officer::body_add_img, 
                width = width, height = height, .init = docx, ...)
}

