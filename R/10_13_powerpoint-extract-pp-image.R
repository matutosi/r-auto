  # パワーポイントからの画像データの取り出し
  # 10_13_powerpoint-extract-pp-image.R
out_dir <- fs::path_temp("desktop")
path_images <- extract_pp_image(path, out_dir, overwrite = TRUE)

