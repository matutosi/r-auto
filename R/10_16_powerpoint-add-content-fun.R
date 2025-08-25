  # タイトルと内容のスライドを挿入する関数
  # 10_16_powerpoint-add-content-fun.R
add_content <- function(pp, title = "", content){
  layout <- "Title and Content"
  name <- "Title and Content"
  ph_label <- "Content Placeholder 2"
  pp <- officer::add_slide(pp, layout = layout)   # スライドの追加
  pp <- officer::ph_with(pp, value = content,     # 内容の追加
                         location = ph_location_type(type = "body"))
  pp <- officer::ph_with(pp, value = title,       # タイトルの追加
                         location = ph_location_type(type = "title"))
  return(pp)
}

