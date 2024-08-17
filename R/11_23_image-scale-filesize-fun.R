  # ファイルサイズを指定してサイズを変更する関数
  # 11_23_image-scale-filesize-fun.R
image_scale_filesize <- function(image, filesize){
  info <- magick::image_info(image)
  fm <- info$format
  fs <- info$filesize
  wd <- info$width
  tmp_path <- fs::file_temp(ext = fm)
  if(fs == 0){                                          # ファイルサイズが0
    magick::image_write(image, tmp_path)                # 一旦保存
    image <- magick::image_read(tmp_path)               # 再読み込み
    fs <- magick::image_info(image)$filesize
  }
  ratio <- 
    (filesize / fs) ^ 0.5 |>                            # 比率の平方根
    `*`(e1 = _, e2 = seq(from = 0.1, to = 3, by = 0.1)) # 0.1-3.0で，0.1刻み
  ratio <- ratio[ratio < 1]                             # 比率が1未満に限定
  tmp_path <-                                           # 複数の一時ファイル
    paste0(fs::path_ext_remove(tmp_path), "_", 
           ratio, "_.", fs::path_ext(tmp_path))
  image_scale_ratio(image, ratio) |>                    # 複数の比率倍の画像
    as.list() |>
    purrr::map2(tmp_path, magick::image_write)          # 一旦保存
  image <- magick::image_read(tmp_path)                 # 再読み込み
  fs <- magick::image_info(image)$filesize              # ファイルサイズ
  index <- 
    which(fs < filesize) |>                             # 指定のサイズ未満
    max()                                               # 最大値
  return(image[index])
}

