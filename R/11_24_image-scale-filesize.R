  # ファイルサイズを指定してたサイズの変更
  # 11_24_image-scale-filesize.R
img_25_fs <- image_scale_filesize(imgs[25], 100000)
image_info(img_25_fs)$filesize # ファイルサイズ
scaled_25 <- image_append(c(imgs[25], img_25_fs))
plot(scaled_25)

