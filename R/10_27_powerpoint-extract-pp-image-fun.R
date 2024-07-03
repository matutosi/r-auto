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

