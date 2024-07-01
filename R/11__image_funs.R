images_write <- function(images, paths){
  formats <- fs::path_ext(paths) # 拡張子の形式
  tibble::tibble(image = as.list(images), path = paths, format = formats) |>
      purrr::pwalk(magick::image_write)
}
image_scale_ratio <- function(image, ratio){
  round(magick::image_info(image)$width * ratio) |>
    purrr::map(magick::image_scale, image = image) |>
    magick::image_join()
}
image_scale_filesize <- function(image, filesize){
  info <- magick::image_info(image)
  fm <- info$format
  fs <- info$filesize
  wd <- info$width
  tmp_path <- fs::file_temp(ext = fm)
  if(fs == 0){ # ファイルサイズが0のとき
    magick::image_write(image, tmp_path) # 一旦保存
    image <- magick::image_read(tmp_path) # 再読み込み
    fs <- magick::image_info(image)$filesize
  }
  ratio <- 
    (filesize / fs) ^ 0.5 |> # 比率の平方根
    `*`(e1 = _, e2 = seq(from = 0.1, to = 3, by = 0.1)) # 0.1倍から3倍まで0.1刻み
  ratio <- ratio[ratio < 1] # 比率が1未満に限定
  tmp_path <-  # 複数の一時ファイル
    paste0(fs::path_ext_remove(tmp_path), "_", 
           ratio, "_.", fs::path_ext(tmp_path))
  image_scale_ratio(image, ratio) |> # 複数の比率倍の画像
    as.list() |>
    purrr::map2(tmp_path, magick::image_write) # 一旦保存
  image <- magick::image_read(tmp_path) # 再読み込み
  fs <- magick::image_info(image)$filesize # ファイルサイズ
  index <- 
    which(fs < filesize) |> # 指定のサイズ未満
    max() # 最大値)
  return(image[index])
}
ltrb2geo <- function(left_top, right_bottom){
    left <- left_top[1]
    top <- left_top[2]
    right <- right_bottom[1]
    bottom <- right_bottom[2]
    geometry <- 
      paste0(right - left, "x", bottom - top, 
      "+", left, "+", top)
    return(geometry)
}
click_locate_image <- function(img, n = 2){
  par(mar = rep(0.1, 4))        # 余白を狭く
  par(oma = rep(0.1, 4))
  plot(img)                     # 描画
  pos <- locator(n = n)         # 位置取得の回数
  pos <- purrr::map(pos, round) # 丸め
  w <- magick::image_info(img)$width
  h <- magick::image_info(img)$height
  pos$y <- h - pos$y            # 上下位置の反転
  pos <- 
    seq(n) |>
    purrr::map(\(i){ c(pos$x[i], pos$y[i]) } )
  return(pos)
}
click_crop_image <- function(path){
  img <- magick::image_read(path)                  # 読み取り
  pos <- click_locate_image(img)                   # 切り取り位置
  geometry <- ltrb2geo(pos[[1]], pos[[2]])         # 位置の変換
  img_croped <- magick::image_crop(img, geometry)  # 切り取り
  path_croped <-                                   # 保存ファイル
    fs::path(fs::path_dir(path), paste0("croped_", fs::path_file(path = path)))
  magick::image_write(img_croped, path_croped)     # 保存
  return(list(path_croped, geometry))
}
gg_point <- function(path, size, color, fill){ # 散布図の描画・保存
  tibble(x = runif(1000), y = runif(1000)) |>
    ggplot(aes(x, y)) + 
    geom_point(shape = 21, size = size, color = color, fill = fill) + 
    theme_bw()
  ggsave(path, width = 5, height = 5)
}
pdf_transparent <- function(path){ # PDF背景の透明化
  path |>
    image_read_pdf() |>
    image_transparent("white") |> # 白を透明化
    image_write(path, format = "pdf")
}
image_annotate_fnames <- function(dir, 
row_index <- function(n, ncol){
  nrow <- ceiling(n %/% ncol)                    # 行数
  n_ends <- seq(nrow) * ncol                     # 各行の終了index
  n_sarts <- dplyr::lag(default = 1, n_ends + 1) # 各行の開始index
  n_ends[nrow] <- n                              # 最終行の最後をnに修正
  rows <- purrr::map2(n_sarts, n_ends, \(x, y){ seq(from = x, to = y) })
  return(rows)
}
same_height <- function(imgs){
  height <- magick::image_info(imgs)$height # 高さ
  width <- magick::image_info(imgs)$width   # 幅
  max_h <- ceiling(max(height) * 0.1) * 10  # 高さの最大値
  border <- max(max_h - height)             # 追加分
  bordered <- magick::image_border(         # 上下に余白を追加
    imgs, color = "white", geometry = paste0("x", border))
  geometry <- paste0(width, "x", max_h, "+0+", border)
  same_sized <-                             # 上の余白を削除
    purrr::map2(as.list(bordered), geometry, magick::image_crop) |>
    magick::image_join()
  return(same_sized)
}
