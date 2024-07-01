  # ファイル名を書き込んで結合する
  # 11_49_image-annotate-fnames.R
dir <- fs::path_temp()
regexp <- "r_\\d+\\.(png|jpg)$"
img_all <- image_annotate_fnames(dir = dir, regexp = regexp, ncol = 8)
plot(img_all)

