  # 条件を満たすファイルにファイル名を書き込んで結合する
  # 11_30_image-annotate-fnames.R
dir <- fs::path_temp()
regexp <- "/r_\\d+\\.(png|jpg)$"
img_all <- image_annotate_fnames(dir = dir, regexp = regexp, ncol = 8) # ファイル名の絞り込み
plot(img_all)

