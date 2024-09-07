  # officerのインストールと呼び出し
  # 10_01_powerpoint-install.R
install.packages("officer")
library("officer")

  # パワーポイントの読み込み
  # 10_02_powerpoint-read.R
url <- "https://matutosi.github.io/r-auto/data/slide.pptx"
path <- fs::path_temp("slide.pptx")
curl::curl_download(url, path) # urlからPDFをダウンロード
pp <- read_pptx(path)

  # パワーポイントの概要表示
  # 10_03_powerpoint-summary.R
pptx_summary(pp) |> 
  tibble::tibble() |>
  print(n = 5)

  # 文字列のデータ
  # 10_04_powerpoint-summary-text.R
pptx_summary(pp) |>
  dplyr::filter(content_type == "paragraph") |>
  tibble::tibble() |> 
  print(n = 5)

  # パワーポイントから文字列を取り出す関数
  # 10_05_powerpoint-extract-pp-text-fun.R
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
  # 10_06_powerpoint-extract-pp-text.R
extract_pp_text(path) |> head(3)

  # 表のデータ
  # 10_07_powerpoint-summary-table.R
pptx_summary(pp) |>
  dplyr::filter(content_type == "table cell") |>
  dplyr::transmute(id, row_id, cell_id, 
                   text = stringr::str_squish(text)) |> # 余分な空白文字を除去
  tibble::tibble() |>
  print(n = 5)

  # パワーポイントから表のデータを取り出す関数
  # 10_08_powerpoint-extract-pp-table-fun.R
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
  # 10_09_powerpoint-extract-pp-table.R
extract_pp_table(path) |> 
  head(1) # 3つの表の内容は同じなので2つ目以降は省略

  # 画像データの一覧の取り出し
  # 10_10_powerpoint-summary-image.R
pptx_summary(pp) |>
  dplyr::filter(content_type == "image") |>
  `$`(_, "media_file") |> 
  head()

  # パワーポイントのファイルのディレクトリ
  # 10_11_powerpoint-package-dir.R
fs::path(pp$package_dir)

  # パワーポイントから画像データを取り出す関数
  # 10_12_powerpoint-extract-pp-image-fun.R
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
  # 10_13_powerpoint-extract-pp-image.R
out_dir <- fs::path_temp("desktop")
path_images <- extract_pp_image(path, out_dir, overwrite = TRUE)

  # レイアウトの確認
  # 10_14_powerpoint-layout.R
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

  # 文字列を箇条書きに変換する関数
  # 10_15_powerpoint-str2ul-fun.R
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

  # タイトルと内容のスライドを挿入する関数
  # 10_16_powerpoint-add-content-fun.R
add_content <- function(pp, title = "", content){
  layout <- "Title and Content"
  name <- "Title and Content"
  ph_label <- "Content Placeholder 2"
  # スライドの追加
  pp <- add_slide(pp, layout = layout)
  # 内容の追加
  pp <- ph_with(pp, value = content,
                location = ph_location_type(type = "body"))
  # タイトルの追加
  pp <- ph_with(pp, value = title,
                location = ph_location_type(type = "title"))
  return(pp)
}

  # タイトルと画像のスライドを挿入する関数
  # 10_17_powerpoint-add-fig-fun.R
add_fig <- function(pp, title = "", path_img, fig_full_size = FALSE,
                    conter_horizontal = TRUE, conter_vertical = TRUE){
  # レイアウト・設置場所
  layout <- "Title and Content"
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
  pp <- add_slide(pp, layout = layout)
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

  # パワーポイントの作成
  # 10_18_powerpoint-generate.R
str <- c("-大項目;--中項目;-大項目;--中項目;--中項目;---小項目;---小項目")
ft <- flextable::flextable(head(iris)) |> flextable::autofit()
gg_iris <- ggplot2::ggplot(iris, 
  ggplot2::aes(Sepal.Length, Petal.Length, color = Species)) +
  ggplot2::geom_point(size = 3) + ggplot2::theme_minimal()
  # install.packages("rvg")
editable_gg <- rvg::dml(ggobj = gg_iris)
r_img <- fs::path_temp("r.png")
curl::curl_download("https://matutosi.github.io/r-auto/data/r_gg.png", r_img)

pp <- 
  read_pptx() |>
  add_content(title = "箇条書き", content = str2ul(str)) |>
  add_content(title = "irisデータ", content = head(iris)) |>
  add_content(title = "iris(flextable)", content = ft) |>
  add_content(title = "ggplotの図", content = gg_iris) |>
  add_content(title = "編集可能な図", content = editable_gg) |>
  add_fig(title = "png等の画像", path_img = r_img)

path <- fs::path_temp("slide.pptx")
print(pp, target = path)
  # shell.exec(path)

  # タイトルと画像のスライドの追加
  # 10_19_powerpoint-add-fig-sample.R
titles <- c("1枚目" , "2枚目" , "3枚目")
images <- path_images[c(1, 5, 9)]   # extract_pp_image()で抽出した画像
pp <- reduce2(titles, images,       # タイトルと画像はスライドで異なる
              add_fig, .init = pp,
              fig_full_size = TRUE) # 以下は全スライドで同じ)

