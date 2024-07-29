  # 複数画像を拡張子の形式で書き込む
  # 11_13_image-write-images.R
exts <- rep(c("png", "jpg", "gif"), 9)
imgs_path <- 
  files |>
  fs::path_file() |>        # ファイル名のみ
  fs::path_ext_set(exts) |> # 拡張子の変更
  fs::path_temp() |>        # 一時ディレクトリ
  print()
images_write(imgs, imgs_path)
  # imgs_path |> purrr::map(shell.exec) # 画像を表示

