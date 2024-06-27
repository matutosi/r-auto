  # サイズの変更
  # 11_27_image-scale.R
r_01_w100 <- image_scale(imgs[1], geometry = "200")
r_01_h250 <- image_scale(imgs[1], geometry = "x50")
scaled <- image_append(c(imgs[1], r_01_w100, r_01_h250))
plot(scaled)

