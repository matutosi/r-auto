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
