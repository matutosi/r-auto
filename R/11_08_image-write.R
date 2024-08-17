  # 画像の書き込み
  # 11_08_image-write.R
image_write(imgs[1], path = fs::path_temp("r_01.pdf"), format = "pdf")
image_write(imgs[2], path = fs::path_temp("r_02.png"))

