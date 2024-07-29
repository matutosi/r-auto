  # 比率指定でのサイズの変更
  # 11_24_image-scale-ratio.R
r_21_050 <- image_scale_ratio(imgs[21], 0.5)
r_21_025 <- image_scale_ratio(imgs[21], 0.25)
scaled_21 <- image_append(c(imgs[21], r_21_050, r_21_025))
plot(scaled_21)

