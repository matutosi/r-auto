  # 画像を全て結合
  # 11_22_image-append-all.R
appended <- 
  image_append(
    c(image_append(imgs[1:8]),
      image_append(imgs[9:16]),
      image_append(imgs[17:24]),
      image_append(imgs[25:27])),
      stack = TRUE)
plot(appended)

