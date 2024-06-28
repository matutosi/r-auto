str2ul <- function(str, sep = ";", symbol = "-"){
  if(length(str) == 1){ # 1つの文字列のとき
    str <- 
      str |>
      stringr::str_split_1(pattern = sep) |> # 区切り文字で分割
      stringr::str_subset("^.+$") # 空文字("")を除去
  }
  str_list <- stringr::str_remove(str, paste0("^", symbol, "*")) # 記号の除去
  level_list <- 
    str |>
    stringr::str_extract(paste0("^", symbol, "*")) |> # 記号の抽出
    stringr::str_count(symbol) # 記号の数(=箇条書きの水準)
  ul <- unordered_list(str_list = str_list,
                       level_list = level_list)
  return(ul)
}
add_fig <- function(pp, title = "", path_img, fig_full_size = FALSE,
preduce <- function(.l, .f, ..., .init, .dir = c("forward", "backward")){
  .dir <- match.arg(.dir)
  purrr::reduce(
    purrr::transpose(.l), 
    \(x, y){ rlang::exec(.f, x, !!!y, ...) }, 
    .init = .init, .dir = .dir)
}
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
extract_pp_image <- function(path, out_dir = NULL, overwrite = TRUE){
  pp <- officer::read_pptx(path) # パワーポイントの読み込み
  image_files <-  # 画像の一覧
    officer::pptx_summary(pp) |> # 概要の取得
    dplyr::filter(content_type == "image") |> # 画像のみ
    `$`(_, "media_file") # 画像のファイル名
  image_files <- fs::path(pp$package_dir, image_files) # 画像ファイル
  image_exts <- fs::path_ext(image_files) # 画像の拡張子
  pp_file <- # ファイル名のみ
    path |>
    fs::path_file() |>  # ディレクトリ除去
    fs::path_ext_remove() # 拡張子除去
  out_files <- # 連番のファイル名
    seq_along(image_files) |> # 連番
    stringr::str_pad(width = 2, pad = "0", side = "left") |> # 桁合わせ
    fs::path_ext_set(image_exts) # 拡張子の設定
  if(is.null(out_dir)){
    out_dir <- fs::path_temp(pp_file) # 一時ディレクトリ
  }else{
    out_dir <- fs::path(out_dir, pp_file)
  }
  out_files <- fs::path(out_dir, out_files)
  fs::dir_create(out_dir)
  fs::file_copy(image_files, out_files, overwrite = overwrite)
  return(out_files)
}
pp2ext <- function(path, format = "png"){
  format_no <- switch(format,
                      ppt = 1, rtf = 5, pptx = 11, ppsx = 28, pdf = 32, 
                      wmf = 15, gif = 16, jpg = 17, png = 18, bmp = 19,
                      tif = 21, emf = 23,
                      wmv = 37, mp4 = 39) # 動画は時間がかかる
  path <- normalizePath(path) # Windowsの形式に変換
  converted <- 
    fs::path_ext_remove(path) |> # 拡張子除去
    normalizePath(mustWork = FALSE)
  # パワーポイントの操作
  ppApp <- RDCOMClient::COMCreate("PowerPoint.Application")
  ppApp[["DisplayAlerts"]] <- FALSE # TRUE：警告の表示
  pp <- ppApp[["Presentations"]]$Open(path) # ファイルを開く
  pp$SaveAs(converted, FileFormat = format_no) # 指定形式で保存
  pp$close()
  cmd <- "taskkill /f /im powerpnt.exe" # パワーポイント終了のコマンド
  system(cmd) # パワーポイント終了
  if(format %in% c("ppt", "rtf", "pptx", "ppsx", "pdf")){ # 拡張子の設定
    converted <- fs::path_ext_set(converted, format)
  }
  return(converted)
}
