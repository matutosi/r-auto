  # 背景の塗りつぶしと重ね合わせ
  # 11_27_image-etc-fill.R
img_filled <- image_fill(imgs[22], color = "#00FFFF", fuzz = 10)
image_flattened <- image_flatten(c(img_filled, imgs[1]))
plot(image_flattened)

