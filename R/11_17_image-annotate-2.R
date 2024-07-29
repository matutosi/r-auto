  # 文字の追加
  # 11_17_image-annotate-2.R
annotated_25 <- 
  bordered_25 |>
  image_annotate("宮古島の\nアオウミガメ", 
  gravity = "southeast", location = "+50+30",
  size = 80, font = fonts[7], color = "white")
plot(annotated_25)

