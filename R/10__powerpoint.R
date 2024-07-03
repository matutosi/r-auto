  # officerのインストール
  # 10_01_powerpoint-install.R
install.packages("officer")

  # officerの呼び出し
  # 10_02_powerpoint-library.R
library("officer")

  # パワーポイントの新規作成
  # 10_03_powerpoint-read.R
library(officer)
pp <- read_pptx()
  # 既存ファイルの読み込み
  # path <- "PATH/TO/POWERPOINT/FILE.pptx"
  # pp <- read_pptx(path)

  # パワーポイントの内容表示
  # 10_04_powerpoint-print.R
pp

  # レイアウトの確認
  # 10_05_powerpoint-layout.R
pp <- read_pptx()
layout_name <-                                    # レイアウト名
  layout_properties(pp)$name |>
  unique()
for(ln in layout_name){                           # レイアウトごとに
  pp <- add_slide(pp, layout = ln)                # スライドを追加
  ph_label <-                                     # プレイスホルダーの一覧
    layout_properties(pp, layout = ln)$ph_label |>
    unique()
  for(pl in ph_label){                            # プレイスホルダーごとに
    val <- pl                                     # プレイスホルダーのラベル
    if(stringr::str_detect(pl, "Title|タイトル")){
      val <- paste0(val, ": ", ln)
    }
    loc <- ph_location_label(ph_label = pl)
    pp <- ph_with(pp, value = val, location = loc) # プレイスホルダーを追加
  }
  if(ln == "Blank"){
    pp <- ph_with(pp, value = ln, location = ph_location())
  }
}
path <- fs::path_temp("layout.pptx")
print(pp, target = path)
  # shell.exec(path)

  # スライドの追加
  # 10_06_powerpoint-add-slide.R
pp <- read_pptx() # 新規作成
layout <- "Two Content"
pp <- add_slide(pp, layout = layout)
path <- fs::path_temp("temp.pptx")
print(pp, target = path)
  # shell.exec(path)

  # 内容の追加
  # 10_07_powerpoint-ph-with.R
pp <- ph_with(pp, value = "Rによる自動化の方法", 
              location = ph_location_type(type = "title"))
pp <- ph_with(pp, paste0("手作業", 1:5), 
              location = ph_location_label(
              ph_label = "Content Placeholder 2"))
pp <- ph_with(pp, paste0("自動化", 1:5), 
              location = ph_location_label(
              ph_label = "Content Placeholder 3"))
print(pp, target = path)
  # shell.exec(path)

  # パワーポイントへの箇条書きの追加
  # 10_08_powerpoint-list.R
ul <- 
  unordered_list(
    level_list = c(1, 2, 3),
    str_list = c("大項目", "中項目", "小項目"),
    style = list(fp_text(color = "red", font.size = 0),
                 fp_text(color = "blue", font.size = 0),
                 fp_text(color = "green", font.size = 0))
pp <- add_slide(pp)
pp <- ph_with(x = pp, value = ul, location = ph_location_type(type = "body"))
ul <- unordered_list(level_list = c(1, 2, 3),
                     str_list = c("大項目", "中項目", "小項目"))
pp <- add_slide(pp)
pp <- ph_with(x = pp, value = ul, location = ph_location_type(type = "body"))
print(pp, target = path)
  # shell.exec(path)

  # 文字列を箇条書きに変換する関数
  # 10_09_powerpoint-str2ul-fun.R
str2ul <- function(str, sep = ";", symbol = "-"){
  if(length(str) == 1){                      # 1つの文字列のとき
    str <- 
      str |>
      stringr::str_split_1(pattern = sep) |> # 区切り文字で分割
      stringr::str_subset("^.+$")            # 空文字("")以外
  }
  str_list <- stringr::str_remove(str, paste0("^", symbol, "*")) # 記号の除去
  level_list <- 
    str |>
    stringr::str_extract(paste0("^", symbol, "*")) |> # 記号の抽出
    stringr::str_count(symbol)                        # 箇条書きの水準
  ul <- unordered_list(str_list = str_list,
                       level_list = level_list)
  return(ul)
}

  # 文字列の箇条書に変換してスライドに追加
  # 10_10_powerpoint-str2ul.R
pp <- add_slide(pp)
str <- c("-大項目;--中項目;-大項目;--中項目;--中項目;---小項目;---小項目")
ul <- str2ul(str, sep = ";")
pp <- ph_with(x = pp, value = ul, location = ph_location_type(type = "body"))
print(pp, target = path)
  # shell.exec(path)

  # 表の追加
  # 10_11_powerpoint-ph-with-table.R
layout <- "Title and Content"
pp <- add_slide(pp, layout = layout)
pp <- ph_with(pp, value = "みんな大好きirisデータ", 
              location = ph_location_type(type = "title"))
pp <- ph_with(pp, head(iris), 
              location = ph_location_label(ph_label = "Content Placeholder 2"))
print(pp, target = path)
  # shell.exec(path)

  # 整形した表の追加
  # 10_12_powerpoint-ph-with-flextable.R
  # install.package("flextable") # 必要に応じてインストール
pp <- add_slide(pp, layout = layout)
 # 表のデータに合わせる
pp <- ph_with(pp, value = "autofitで整形したirisデータ", 
              location = ph_location_type(type = "title"))
ft <- flextable::flextable(head(iris))
ft <- flextable::autofit(ft)
pp <- ph_with(pp, ft, 
              location = ph_location_label(ph_label = "Content Placeholder 2"),
              )
  # 個別に指定
pp <- add_slide(pp, layout = layout)
pp <- ph_with(pp, value = "個別に指定したirisデータ", 
              location = ph_location_type(type = "title"))
ft <- flextable::width(ft, width = 1.8)
ft <- flextable::height_all(ft, height = 0.75)
ft <- flextable::hrule(ft, rule = "exact", part = "all")
pp <- ph_with(pp, ft, 
              location = ph_location_label("Content Placeholder 2")
              )
print(pp, target = path)
  # shell.exec(path)

  # スライドに画像を追加
  # 10_13_powerpoint-ph-with-img.R
url <- "https://matutosi.github.io/r-auto/data/r_gg.png"
path_img <- fs::path_temp("r_gg.png")
curl::curl_download(url, path_img) # urlからPDFをダウンロード
  # ph_location_fullsize()：スライド全体
pp <- add_slide(pp)
pp <- ph_with(pp, 
              value = external_img(path_img),
              location = ph_location_fullsize())
pp <- ph_with(pp, value = "ph_location_fullsize()：\nスライド全体", 
              location = ph_location_type(type = "title"))
  # use_loc_size = TRUE：指定位置全体
pp <- add_slide(pp)
pp <- ph_with(pp, 
              value = external_img(path_img),
              location = ph_location_type(type = "body"), use_loc_size = TRUE)
pp <- ph_with(pp, value = "use_loc_size = TRUE：\n指定位置全体", # \nで改行
              location = ph_location_type(type = "title"))
  # guess_size = TRUE：画像のもとの大きさ
pp <- add_slide(pp)
pp <- ph_with(pp, 
              value = external_img(path_img, guess_size = TRUE),
              location = ph_location_type(type = "body"), use_loc_size = FALSE)
pp <- ph_with(pp, value = "guess_size = TRUE：\n画像のもとの大きさ", 
              location = ph_location_type(type = "title"))
  # widthとheightで大きさ指定
pp <- add_slide(pp)
pp <- ph_with(pp, 
              value = external_img(path_img, width = 5, height = 5),
              location = ph_location_type(type = "body"),
              use_loc_size = FALSE)
pp <- ph_with(pp, value = "widthとheightで\n大きさ指定", 
              location = ph_location_type(type = "title"))
print(pp, target = path)
  # shell.exec(path)

  # Title and Contentのレイアウトでタイトルと画像を挿入する関数
  # 10_14_powerpoint-add-fig-fun.R
add_fig <- function(pp, title = "", path_img, fig_full_size = FALSE,
                    conter_horizontal = TRUE, conter_vertical = TRUE){
  # レイアウト・設置場所
  name <- "Title and Content"
  ph_label <- "Content Placeholder 2"
  # スライドのサイズ
  ss <- slide_size(pp)
  # 配置場所のサイズ
  cont_ph <- 
    layout_properties(pp) |>
    dplyr::filter(name == {{name}} & ph_label == {{ph_label}})
  if(fig_full_size){
    offx <- 0
  }else{
    offx <- cont_ph$offx
  }
  offy <- cont_ph$offy
  # 配置サイズ：全体 - offset
  w_cont <- ss$width  - offx * 2 # 幅，* 2：左右分
  h_cont <- ss$height - offy     # 高さ
  # 画像のサイズ
  img <- magick::image_read(path_img)
  w_img <- magick::image_info(img)$width
  h_img <- magick::image_info(img)$height
  # 縦横比
  ratio_img <- w_img / h_img      # 画像
  ratio_cont <- w_cont / h_cont   # 配置場所
  ratio <- ratio_img / ratio_cont # 画像と配置場所の比率
    # 縦長・横長での補正
  if(ratio > 1){
    h_cont <- h_cont / ratio # 図が横長
  }else{
    w_cont <- w_cont * ratio # 図が縦長
  }
  # 補正
  if(conter_horizontal){ # 水平方向
    offx <- (ss$width - w_cont) / 2
  } 
  if(conter_vertical){   # 垂直方向
    offy <- (offy + ss$height - h_cont) / 2
  }
  # スライドの追加
  pp <- add_slide(pp, layout = "Title and Content")
  # 画像の追加
  pp <- ph_with(pp, 
                value = external_img(path_img),
                location = ph_location(left = offx, top = offy,
                                       width = w_cont, height = h_cont))
  # タイトルの追加
  pp <- ph_with(pp, value = title,
                location = ph_location_type(type = "title"))
  return(pp)
}

  # Title and Contentのレイアウトでのタイトルと画像の挿入
  # 10_15_powerpoint-add-fig.R
  # pp <- read_pptx()
imgs <- c("image_03_wide.jpg", "r_07.png")
urls <- paste0("https://matutosi.github.io/r-auto/data/", imgs)
path_imgs <- fs::path_temp(imgs)
curl::multi_download(urls, path_imgs) # urlからPDFをダウンロード
wide <- path_imgs[1]
long <- path_imgs[2]
df <- 
  tibble::tribble(
    ~title             , ~path, ~conter_horiz , ~conter_vert , ~fig_full,
    "横長(全体)"       , wide , FALSE         ,  FALSE       , TRUE     ,
    "横長(全体，中央)" , wide , TRUE          ,  TRUE        , TRUE     ,
    "横長(余白)"       , wide , FALSE         ,  FALSE       , FALSE    ,
    "横長(余白，中央)" , wide , TRUE          ,  TRUE        , FALSE    ,
    "縦長(全体)"       , long , FALSE         ,  FALSE       , TRUE     ,
    "縦長(全体，中央)" , long , TRUE          ,  TRUE        , TRUE     ,
    "縦長(余白)"       , long , FALSE         ,  FALSE       , FALSE    ,
    "縦長(余白，中央)" , long , TRUE          ,  TRUE        , FALSE    
  )
  # purrr::reduce()をデータフレームに適用する糖衣関数
preduce <- function(.l, .f, ..., .init, .dir = c("forward", "backward")){
  .dir <- match.arg(.dir)
  purrr::reduce(
    purrr::transpose(.l), 
    \(x, y){ rlang::exec(.f, x, !!!y, ...) }, 
    .init = .init, .dir = .dir)
}
pp <- preduce(df, add_fig, .init = pp)
print(pp, target = path)
  # shell.exec(path)

  # タイトルと画像のスライドの追加(擬似コード)
  # 10_16_powerpoint-add-fig-sample.R
titles <- c("1枚目" , "2枚目" , "3枚目")
images <- c("01.png", "02.png", "03.png")
pp <- read_pptx()
pp <- reduce2(titles, images,           # タイトルと画像はスライドで異なる
              add_fig, .init = pp, 
              fig_full_size = TRUE,     # 以下は全スライドで同じ
              conter_horizontal = TRUE,
              conter_vertical = TRUE)
print(pp, target = path)
  # shell.exec(path)

  # ggplotのグラフを追加
  # 10_17_powerpoint-ggplot.R
  # install.packages("rvg")
gg_iris <- # ggplotオブジェクト
  iris |> 
  ggplot2::ggplot(ggplot2::aes(Sepal.Length, Petal.Length, color = Species)) +
  ggplot2::geom_point(size = 3) + 
  ggplot2::theme_minimal()
  # スライドの最大サイズで追加
pp <- add_slide(pp) 
pp <- ph_with(pp, "最大サイズでのggplotの追加",
              location = ph_location_type(type = "title"))
pp <- ph_with(pp, gg_iris, location = ph_location_fullsize())
  # 指定位置の大きさで追加
pp <- add_slide(pp)
pp <- ph_with(pp, "Placeholder 2への追加", 
              location = ph_location_type(type = "title"))
pp <- ph_with(pp, gg_iris, 
              location = ph_location_label("Content Placeholder 2"))
  # 編集可能な図として追加
editable_gg <- rvg::dml(ggobj = gg_iris)
pp <- add_slide(pp)
pp <- ph_with(pp, "編集可能な図として追加", 
              location = ph_location_type(type = "title"))
pp <- ph_with(pp, editable_gg,
              location = ph_location_label("Content Placeholder 2"))
  # パワーポイントの保存
print(pp, target = path)
  # shell.exec(path)

  # パワーポイントの概要表示
  # 10_18_powerpoint-summary.R
library(officer)
pp |>
  pptx_summary() |>
  tibble::tibble()

  # 文字列のデータ
  # 10_19_powerpoint-summary-text.R
pptx_summary(pp) |>
  dplyr::filter(content_type == "paragraph") |>
  tibble::tibble()

  # パワーポイントから文字列を取り出す関数
  # 10_20_extract-pp-text-fun.R
extract_pp_text <- function(path){
  paragraph <- 
    path |>
    read_pptx() |>
    pptx_summary() |>
    dplyr::filter(content_type  == "paragraph") |> # 文字列のみ
    dplyr::filter(text != "") |> # 空を除去
    dplyr::select(slide_id, text) # 
  text <- 
    paragraph |>
    dplyr::mutate(dammy = "text") |> # pivot_wider()で使うダミー列
    tidyr::pivot_wider(id_cols = slide_id, # スライドごとに
                       names_from = dammy, 
                       values_from = text, # 文字列を
                       values_fn = list) |> # リストに
    `$`(_, "text") # 文字列を取り出し
  return(text)
}

  # パワーポイントからの文字列の取り出し
  # 10_21_extract-pp-text.R
extract_pp_text(path) |> 
  head(3)

  # 表のデータ
  # 10_22_powerpoint-summary-table.R
pptx_summary(pp) |>
  dplyr::filter(content_type == "table cell") |>
  dplyr::transmute(id, row_id, cell_id, 
                   text = stringr::str_squish(text)) |> # 余分な空白文字を除去
  tibble::tibble()

  # パワーポイントから表のデータを取り出す関数
  # 10_23_powerpoint-extract-pp-table-fun.R
extract_pp_table <- function(path){
  table <- 
    path |>
    read_pptx() |>
    pptx_summary() |>
    dplyr::filter(content_type == "table cell") |>
    pivotea::pivot(row = "row_id", col = "cell_id", 
                   value = "text", split = c("id", "slide_id"))
  return(table)
}

  # パワーポイントからの表のデータの取り出し
  # 10_24_powerpoint-extract-pp-table.R
extract_pp_table(path) |> 
  head(1) # 3つの表の内容は同じなので2つ目以降は省略

  # 画像データの一覧の取り出し
  # 10_25_powerpoint-summary-image.R
pptx_summary(pp) |>
  dplyr::filter(content_type == "image") |>
  `$`(_, "media_file") |> 
  head()

  # パワーポイントのファイルのディレクトリ
  # 10_26_powerpoint-package-dir.R
fs::path(pp$package_dir)

  # パワーポイントから画像データを取り出す関数
  # 10_27_powerpoint-extract-pp-image-fun.R
extract_pp_image <- function(path, out_dir = NULL, overwrite = TRUE){
  pp <- officer::read_pptx(path)                           # 読み込み
  imgs <-                                                  # 画像の一覧
    officer::pptx_summary(pp) |>                           # 概要の取得
    dplyr::filter(content_type == "image")                 # 画像のみ
  slide_id <- imgs$slide_id |>                             # スライドid
    stringr::str_pad(width = 2, side = "left", pad = "0")  # 桁合わせ
  image_files <- fs::path(pp$package_dir, imgs$media_file) # 画像ファイル
  image_exts <- fs::path_ext(image_files)                  # 画像の拡張子
  pp_file <-
    path |>
    fs::path_file() |>                                     # ディレクトリ除去
    fs::path_ext_remove()                                  # 拡張子除去
  out_files <-                                             # 連番のファイル名
    seq_along(image_files) |>                              # 連番
    stringr::str_pad(width = 2, side = "left", pad = "0")  # 桁合わせ
  out_files <-
    paste0(slide_id, "_", out_files) |>                    # スライド番号追加
    fs::path_ext_set(image_exts)                           # 拡張子の設定
  if(is.null(out_dir)){
    out_dir <- fs::path_temp(pp_file)                      # 一時ディレクトリ
  }else{
    out_dir <- fs::path(out_dir, pp_file)
  }
  out_files <- fs::path(out_dir, out_files)
  fs::dir_create(out_dir)
  fs::file_copy(image_files, out_files, overwrite = overwrite)
  return(out_files)
}

  # パワーポイントからの画像データの取り出し
  # 10_28_powerpoint-extract-pp-image.R
out_dir <- fs::path_home("desktop")
extract_pp_image(path, out_dir, overwrite = TRUE)

  # RDCOMClientのインストール
  # 10_29_RDCOMClient-install.R
  # zipファイルでのインストール
install.packages("RDCOMClient", 
                 repos = "http://www.omegahat.net/R", type = "win.binary")

  # ソースファイルからビルドしてインストール
  # install.packages("remotes") # remotesをインストールしていないとき
  # Rtoolsも必要
remotes::install_github("omegahat/RDCOMClient")

  # パワーポイントを画像・PDF・動画に変換する関数
  # 10_30_powerpoint-pp2img-fun.R
pp2ext <- function(path, format = "png"){
  format_no <- switch(format,
                      ppt = 1, rtf = 5, pptx = 11, ppsx = 28, pdf = 32, 
                      wmf = 15, gif = 16, jpg = 17, png = 18, bmp = 19,
                      tif = 21, emf = 23,
                      wmv = 37, mp4 = 39)
  path <- normalizePath(path)                               # Windows形式
  converted <- 
    fs::path_ext_remove(path) |>                            # 拡張子除去
    normalizePath(mustWork = FALSE)
  ppApp <- RDCOMClient::COMCreate("PowerPoint.Application") # パワーポイント
  ppApp[["DisplayAlerts"]] <- FALSE                         # 警告を非表示
  pp <- ppApp[["Presentations"]]$Open(path)                 # ファイルを開く
  pp$SaveAs(converted, FileFormat = format_no)              # 指定形式で保存
  pp$close()
  cmd <- "taskkill /f /im powerpnt.exe"                     # 終了コマンド
  system(cmd)                                               # コマンド実行
  if(format %in% c("ppt", "rtf", "pptx", "ppsx", "pdf")){   # 拡張子の設定
    converted <- fs::path_ext_set(converted, format)
  }
  return(converted)
}

  # パワーポイントのpngへの変換
  # 10_31_powerpoint-pp2img-png.R
library(RDCOMClient) # 最初は呼び出さないとエラーになる
pp2ext(path, format = "png")

  # パワーポイントのPDFへの変換
  # 10_32_powerpoint-pp2img-pdf.R
pp2ext(path, format = "pdf")

  # パワーポイントのmp4への変換
  # 10_33_powerpoint-pp2img-mp4.R
pp2ext(path, format = "mp4") # 時間がかかる，ポップアップのクリックが必要_

