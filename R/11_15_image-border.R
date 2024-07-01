  # 枠(余白)の追加
  # 11_15_image-border.R
bordered_01 <- image_border(imgs[1], color = "gold", geometry = "40x40")
bordered_25 <- image_border(imgs[25], color = gray(0.1), geometry = "x300")
par(mfrow = c(1,2)) # 描画パネルの分割
par(mar = rep(0, 4))
par(oma = rep(0, 4))
plot(bordered_01); plot(bordered_25)

