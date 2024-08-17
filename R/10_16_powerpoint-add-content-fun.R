  # タイトルと内容のスライドを挿入する関数
  # 10_16_powerpoint-add-content-fun.R
add_content <- function(pp, title = "", content){
  layout <- "Title and Content"
  name <- "Title and Content"
  ph_label <- "Content Placeholder 2"
  # スライドの追加
  pp <- add_slide(pp, layout = layout)
  # 内容の追加
  pp <- ph_with(pp, value = content,
                location = ph_location_type(type = "body"))
  # タイトルの追加
  pp <- ph_with(pp, value = title,
                location = ph_location_type(type = "title"))
  return(pp)
}

