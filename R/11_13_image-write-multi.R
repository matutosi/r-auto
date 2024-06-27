  # 複数画像の書き込み
  # 11_13_image-write-multi.R
len <- length(imgs)
path_alpha <- fs::path_temp(paste0(letters[seq(len)], ".png"))
imgs |>
  as.list() |> # walk()を使うためリストに変換
  purrr::walk2(path_alpha, image_write, format = "png")

