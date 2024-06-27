  # magickのインストール
  # 11_01_image-install.R
install.packages("magick")
install.packages("rsvg")

  # magickの呼び出し
  # 11_02_image-library.R
library(magick)
  # library(rsvg) # svg形式を使うとき

  # screenshotのインストールと呼び出し
  # 11_03_image-screenshot-install.R
install.packages("screenshot")
library(screenshot)

  # 画像のダウンロード
  # 11_04_image-download.R
rs <- paste0("r_", stringr::str_pad(1:24, 2, "left", pad = "0"), ".png")
pts <- paste0("image_", c("01", "02", "03"), ".jpg")
files <- c(pts, rs)
urls <- paste0("https://matutosi.github.io/r-auto/data/", files)
files <- fs::path_temp(files)
curl::multi_download(urls, files)

  # 画像の読み込み
  # 11_05_image-read.R
imgs <- image_read(files)
imgs
imgs[1] # 個別の画像の取り出し

  # 複数画像の描画
  # 11_06_image-plot-single.R
plot(imgs[1])

  # 複数画像の描画
  # 11_07_image-plot-multiple.R
par(mfrow = c(3,9)) # 描画パネルの分割
par(mar = rep(0, 4))
par(oma = rep(0, 4))
imgs |>
  as.list() |> # walk()を使うためリストに変換
  purrr::walk(plot) # 繰り返し

  # リストへの変換と画像オブジェクトに戻す操作
  # 11_08_image-join.R
imgs |> as.list()
imgs |> as.list() |> image_join()

  # 画像の情報表示
  # 11_09_image-info.R
image_info(imgs)
image_info(imgs[1])

  # 画像の高さ
  # 11_10_image-info-details.R
image_info(imgs)$height

  # 画像の変換
  # 11_11_image-convert.R
image_convert(imgs, format = "jepg")

  # 画像の書き込み
  # 11_12_image-write.R
image_write(imgs[1], path = fs::path_temp("r_01.pdf"), format = "pdf")
image_write(imgs[2], path = fs::path_temp("r_02.png"))

  # 複数画像の書き込み
  # 11_13_image-write-multi.R
len <- length(imgs)
path_alpha <- fs::path_temp(paste0(letters[seq(len)], ".png"))
imgs |>
  as.list() |> # walk()を使うためリストに変換
  purrr::walk2(path_alpha, image_write, format = "png")

  # 複数画像を拡張子の形式で書き込む関数
  # 11_14_image-write-images-fun.R
images_write <- function(images, paths){
  formats <- fs::path_ext(paths) # 拡張子の形式
  tibble::tibble(image = as.list(images), path = paths, format = formats) |>
      purrr::pwalk(magick::image_write)
}

  # 複数画像を拡張子の形式で書き込む
  # 11_15_image-write-images.R
imgs_path <- 
  files |>
  fs::path_file() |> # ファイル名のみ
  fs::path_ext_set(rep(c("png", "jpg", "gif"), 9)) |> # 拡張子の変更
  fs::path_temp() |> # 一時ディレクトリ
  print()
images_write(imgs, imgs_path)
  # imgs_path |> purrr::map(shell.exec) # 画像を表示

  # 枠(余白)の追加
  # 11_16_image-border.R
bordered_01 <- image_border(imgs[1], color = "gold", geometry = "40x40")
bordered_25 <- image_border(imgs[25], color = gray(0.1), geometry = "x300")
par(mfrow = c(1,2)) # 描画パネルの分割
par(mar = rep(0, 4))
par(oma = rep(0, 4))
plot(bordered_01); plot(bordered_25)

  # 使用できるフォントの例
  # 11_17_image-font.R
  # install.packages("magick", repos = "https://ropensci.r-universe.dev")
fonts <- 
  magick_fonts()$family |>
  stringr::str_subset("Meiryo|Yu") |>
  unique() |>
  print()

  # 文字の追加
  # 11_18_image-annotate-1.R
annotated_01 <- 
  image_annotate(bordered_01, "Rで自動化", size = 30, font = fonts[3])
plot(annotated_01)

  # 文字の追加
  # 11_19_image-annotate-2.R
annotated_25 <- 
  bordered_25 |>
  image_annotate("宮古島の\nアオウミガメ", 
  gravity = "southeast", location = "+50+30",
  size = 80, font = fonts[7], color = "white")
plot(annotated_25)

  # 横方向への結合
  # 11_20_image-append-horizontal.R
image_append(imgs[1:24]) |>
  plot() # 横方向

  # 縦方向への結合
  # 11_21_image-append-vertical.R
image_append(imgs[25:27], stack = TRUE)  |> # 縦方向
  plot()

  # 間隔を開けた結合
  # 11_22_image-append-border.R
imgs[1:3] |>
  image_border(color = gray(0.8), geometry = "30") |>
  image_append() |>
  plot()

  # 画像を全て結合
  # 11_23_image-append-all.R
appended <- 
  image_append(
    c(image_append(imgs[1:8]),
      image_append(imgs[9:16]),
      image_append(imgs[17:24]),
      image_append(imgs[25:27])),
      stack = TRUE)
plot(appended)

  # 背景の塗りつぶし
  # 11_24_image-ffill.R
filled_06 <- image_fill(imgs[6], "gold")
plot(filled_06)

  # fuzzを指定した背景の塗りつぶし
  # 11_25_image-ffill-fuzz.R
image_fill(imgs[27], "white", fuzz = 20) |> 
  plot()

  # 余白の除去
  # 11_26_image-trim.R
img_06_07 <- c(filled_06, imgs[7])
trimed <- image_trim(img_06_07)
c(img_06_07, trimed) |>
  image_border(gray(0.7), "10x10") |> 
  image_append() |> 
  plot()

  # サイズの変更
  # 11_27_image-scale.R
r_01_w100 <- image_scale(imgs[1], geometry = "200")
r_01_h250 <- image_scale(imgs[1], geometry = "x50")
scaled <- image_append(c(imgs[1], r_01_w100, r_01_h250))
plot(scaled)

  # 比率を指定して画像サイズを変更する関数
  # 11_28_image-scale-ratio-fun.R
image_scale_ratio <- function(image, ratio){
  round(magick::image_info(image)$width * ratio) |>
    purrr::map(magick::image_scale, image = image) |>
    magick::image_join()
}

  # 比率指定でのサイズの変更
  # 11_29_image-scale-ratio.R
r_21_050 <- image_scale_ratio(imgs[21], 0.5)
r_21_025 <- image_scale_ratio(imgs[21], 0.25)
scaled_21 <- image_append(c(imgs[21], r_21_050, r_21_025))
plot(scaled_21)

  # ファイルサイズを指定してサイズを変更する関数
  # 11_30_image-scale-filesize-fun.R
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

  # ファイルサイズを指定してたサイズの変更
  # 11_31_image-scale-filesize.R
img_25_fs <- image_scale_filesize(imgs[25], 100000)
image_info(img_25_fs)$filesize # ファイルサイズ
scaled_25 <- image_append(c(imgs[25], img_25_fs))
plot(scaled_25)

  # tesseractのインストール
  # 11_32_pdf-tesseract-install.R
install.packages("tesseract")
tesseract::tesseract_download(lang = "jpn")

  # 画像内の文字認識
  # 11_33_image-ocr.R
jps <- "jps.png"
url <- paste0("https://matutosi.github.io/r-auto/data/", jps)
path <- fs::path_temp(jps)
curl::curl_download(url, path)
path |>
  image_read() |>
  image_ocr(lang = "jpn") |>
  cat()

  # ```{r image-binarization-package, eval = FALSE, subject = 'install.packages()', caption = 'image.binarizationのインストール'}
  # 11_34_image-binarization-package.R
install.packages("image.binarization")
library(image.binarization)

  # 画像の2値化
  # 11_35_image-binarization.R
img_bin <- 
  path |>
  image_read() |>
  image_convert(colorspace = "Gray") |>
  image.binarization::image_binarization(type = "wolf")
plot(img_bin)

  # 2値化した画像の文字認識
  # 11_36_image-binarization-ocr.R
img_bin |>
  image_ocr(lang = "jpn") |>
  cat()

  # 傾きの追加
  # 11_37_image-rotate.R
rotated <- 
  image_border(imgs[10], color = gray(0.1), geometry = "10x10") |>
  image_rotate(5)
plot(rotated)

  # 傾きの補正
  # 11_38_image-deskew.R
deskewed <- image_deskew(rotated)
plot(deskewed)

  # 部分の切り取り
  # 11_39_image-crop.R
croped <- image_crop(imgs[25], "600x500+400+450")
plot(croped)

  # ```{r image-ltrb2geo-fun, subject = 'ltrb2geo()', caption = '左上・右下の位置をgeometryに変換する関数'}
  # 11_40_image-ltrb2geo-fun.R
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

  # ```{r image-ltrb2geo, eval = FALSE, subject = 'ltrb2geo()', caption = '左上・右下の位置のでの切り取り'}
  # 11_41_image-ltrb2geo.R
geometry <- ltrb2geo(c(400, 450), c(1000, 950))
geometry
croped_ltrb <- image_crop(imgs[25], geometry = geometry)
plot(croped_ltrb)

  # 画像をクリックして位置を取得する関数
  # 11_42_image-click-locate-image-fun.R
click_locate_image <- function(img, n = 2){
  par(mar = rep(0.1, 4)) # 余白を狭く
  par(oma = rep(0.1, 4))
  plot(img) # 描画
  pos <- locator(n = n) # 位置取得の回数
  pos <- purrr::map(pos, round) # 丸め
  w <- magick::image_info(img)$width
  h <- magick::image_info(img)$height
  pos$y <- h - pos$y # 上下位置の反転
  pos <- 
    seq(n) |>
    purrr::map(\(i){ c(pos$x[i], pos$y[i]) } )
  return(pos)
}

  # 画像をクリックした位置の取得
  # 11_43_image-click-locate-image.R
pos <- 
  imgs[25] |>
  image_scale("1200") |>
  click_locate_image(n = 2)
pos
[[1]]
[1] 395 450
[[2]]
[1] 736 724

  # 複数画像の同一位置での切り取り
  # 11_44_image-click-locate-image-multi.R
geometry <- ltrb2geo(pos[[1]], pos[[2]])
croped_multi <- 
  imgs[25:27] |>
  image_scale("1200") |>
  as.list() |>
  purrr::map(image_crop, geometry) |>
  image_join()
croped_multi
croped_multi |>
  image_border("white", "10") |>
  image_append() |>
  plot()

  # 指定範囲を切り取る関数
  # 11_45_click-crop-image-fun.R
click_crop_image <- function(path){
  img <- magick::image_read(path) # 読み取り
  pos <- click_locate_image(img)  # 切り取り位置の指定
  geometry <- ltrb2geo(pos[[1]], pos[[2]]) # 位置の変換
  img_croped <- magick::image_crop(img, geometry)  # 切り取り
  path_croped <- # 保存ファイル
    fs::path(fs::path_dir(path), paste0("croped_", fs::path_file(path = path)))
  magick::image_write(img_croped, path_croped) # 保存
  return(list(path_croped, geometry))
}

  # 指定範囲の連続切り取り
  # 11_46_click-crop-image.R
path_imgs <- fs::path_temp(files)
  # map
path_imgs[1:3] |>
  purrr::map(click_crop_image)
  # for
for(path in path_imgs[1:3]){
  click_crop_image(path)
}

  # ```{r image-morph-animate, eval = FALSE, subject = 'image_()', caption = ''}
  # 11_47_image-morph-animate.R
animated <- fs::path_temp("animated.gif")
mor <- 
  c(imgs[22], imgs[9], imgs[12], imgs[22]) |>
  image_trim() |>           # 余白の除去
  image_resize("x200") |>   # サイズ合わせ
  image_morph(10) |>        # 中間画像の生成
  image_animate(fps = 5) |> # アニメーション化
  image_write(animated)
  # shell.exec(animated)

  # PDFファイルの背景の透明化
  # 11_48_image-etc-transparent.R
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
path <- fs::path_temp(c("gg_1.pdf", "gg_2.pdf"))      # 個別の散布図のPDF
path_out <- fs::path_temp(c("fill.pdf", "trans.pdf")) # 重ね合わせしたPDF
tibble(path = path, 
       color = c("black", "red"),
       size = c(1, 5),
       fill = c("black", "white")) |>
  purrr::pwalk(gg_point)
  # 透明化・重ね合わせ
qpdf::pdf_overlay_stamp(path[1], path[2], out = path_out[1]) # 透明化前
purrr::walk(path, pdf_transparent)                           # 透明化
qpdf::pdf_overlay_stamp(path[1], path[2], out = path_out[2]) # 透明化後
out <- pdftools::pdf_combine(c(path, path_out))              # 全PDFを結合
  # shell.exec(out)

  # ディレクトリ内の画像にファイル名を書き込んで結合する関数
  # 11_49_image-annotate-fnames-fun.R
image_annotate_fnames <- function(dir, 
  regexp = "\\.(png|jpg)$", ncol = NULL, 
  scale = "200", border = "x30", size = 25, color = "white"){
  fnames <- fs::dir_ls(dir, regexp = regexp)
  annotated <- 
    magick::image_read(fnames) |> # 読み込み
    magick::image_trim() |>       # 余白の削除
    magick::image_scale(geometry = scale) |> # サイズ変更
    magick::image_border(color = color, geometry = border) |> # 余白の追加
    as.list() |>
    purrr::map2(fs::path_file(fnames), 
      magick::image_annotate, size = size) |> # 註釈の追加
    magick::image_join() # 結合
  same_sized <- same_height(annotated) # サイズの整理
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
  nrow <- ceiling(n %/% ncol) # 行数
  n_ends <- seq(nrow) * ncol # 各行の終了index
  n_sarts <- dplyr::lag(default = 1, n_ends + 1) # 各行の開始index
  n_ends[nrow] <- n # 最終行の最後をnに修正
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
  same_sized <- # 上の余白を削除
    purrr::map2(as.list(bordered), geometry, magick::image_crop) |>
    magick::image_join()
  return(same_sized)
}

  # ファイル名を書き込んで結合する
  # 11_50_image-annotate-fnames.R
dir <- fs::path_temp()
regexp <- "r_\\d+\\.(png|jpg)$"
img_all <- image_annotate_fnames(dir = dir, regexp = regexp, ncol = 8)
plot(img_all)

  # スクリーンショットのためのアプリのインストール
  # 11_51_image-screenshot-install-screenshot.R
screenshot::install_screenshot()

  # スクリーンショットの保存
  # 11_52_image-screenshot-screenshot.R
ss <- screenshot::screenshot()
fs::path_file(ss) # ファイル名のみ
 ## [1] "sc_158839211323.png"
magick::image_read(ss)
  # shell.exec(ss) # 関連付けアプリで起動

  # スクリーンショットの保存
  # 11_53_image-screenshot.R
clipboard_img <- save_clipboard_image()
  # shell.exec(clipboard_img)

  # ```{r img-save-screenshot-code, eval = FALSE, subject = 'save_clipboard_image()', caption = ''}
  # 11_54_img-save-screenshot-code.R
  # 保存先ディレクトリ
wd <- fs::path(fs::path_home(), "desktop")
setwd(wd)
  # 保存ファイルの指定
no <- stringr::str_pad(1:99, width = 2, side = "left", pad = "0") # 2桁の連番
path <- paste0("clip_image_", no, ".png")
pngs <- fs::dir_ls(regexp = "\\.png")  # 既存ファイル
path <- setdiff(path, pngs)[1] # 既存ファイル以外での1つ目
  # 画像の保存
screenshot::save_clipboard_image(path)
 # ファイル名をクリップボードに保存
write.table(path, "clipboard", quote = FALSE, row.names = FALSE, col.names = FALSE)

