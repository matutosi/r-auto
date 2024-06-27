  # 画像をクリックした位置の取得
  # 11_43_image-click-locate-image.R
pos <- 
  imgs[25] |>
  image_scale("1200") |>
  click_locate_image(n = 2)
pos
[[1]]
[1] 395 450
[[2]]
[1] 736 724

