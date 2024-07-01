  # ディレクトリ内の画像にファイル名を書き込んで結合する関数
  # 11_49_image-annotate-fnames-fun.R
image_annotate_fnames <- function(dir, 
  regexp = "\\.(png|jpg)$", ncol = NULL, 
  scale = "200", border = "x30", size = 25, color = "white"){
  fnames <- fs::dir_ls(dir, regexp = regexp)
  annotated <- 
    magick::image_read(fnames) |>                             # 読み込み
    magick::image_trim() |>                                   # 余白の削除
    magick::image_scale(geometry = scale) |>                  # サイズ変更
    magick::image_border(color = color, geometry = border) |> # 余白の追加
    as.list() |>
    purrr::map2(fs::path_file(fnames), 
      magick::image_annotate, size = size) |>                 # 註釈の追加
    magick::image_join()                                      # 結合
  same_sized <- same_height(annotated)                        # サイズの統一
  n <- length(fnames)
  if(is.null(ncol)){
    ncol <- ceiling(n^0.5)
  }
  rows <- row_index(n, ncol) # 
  appended <- 
    rows |>
    purrr::map(\(x){ image_append(same_sized[x]) }) |>
    magick::image_join() |>
    magick::image_append(stack = TRUE)
  return(appended)
}
  # 画像数と列数をもとに，行の画像の配列を設定
row_index <- function(n, ncol){
  nrow <- ceiling(n %/% ncol)                    # 行数
  n_ends <- seq(nrow) * ncol                     # 各行の終了index
  n_sarts <- dplyr::lag(default = 1, n_ends + 1) # 各行の開始index
  n_ends[nrow] <- n                              # 最終行の最後をnに修正
  rows <- purrr::map2(n_sarts, n_ends, \(x, y){ seq(from = x, to = y) })
  return(rows)
}
  # 画像の高さを揃える
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

