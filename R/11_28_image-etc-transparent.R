  # 透明化後に重ね合わせ
  # 11_28_image-etc-transparent.R
image_trans <- image_transparent(imgs[1], "white", fuzz = 10)
image_flattened_tr <- image_flatten(c(img_filled, image_trans))
plot(image_flattened_tr)

