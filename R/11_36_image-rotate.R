  # 傾きの追加
  # 11_36_image-rotate.R
rotated <- 
  image_border(imgs[10], color = gray(0.1), geometry = "10x10") |>
  image_rotate(5)
plot(rotated)

