  # ワードから文字列を抽出する関数
  # 08_08_word-docx-extract-text-fun.R
extract_docx_text <- function(docx, normal = TRUE, heading = TRUE, flatten = TRUE){
  if(sum(normal, heading) == 0){ # 両方ともFALSEのとき
    return("") # ""を返す
  }
  condtion <-  # 検索条件："normal|heading", "normal", "heading" のうち1つ
    c("Normal"[normal], "heading"[heading]) |>
    paste0(collapse = "|")
  text <-      # 文字列
    docx |>
    officer::docx_summary() |>
    dplyr::filter(stringr::str_detect(style_name, condtion)) |>
    dplyr::filter(text != "") |>
    dplyr::select(text)
  if(flatten) text <- text$text
  return(text)
}
  # 文字列を比較して異なるときのみ貼り付ける関数
  # 08_16_word-cumulative-paste-fun.R
cumulative_paste <- function(x, y){
  if(x == y){    # xとyが同じなら
    x            #   xのまま
  }else{         # xとyが異なれば
    paste0(x, y) #   xとyを貼り付け
  }
}
  # ディクトリ内のワードから画像を抽出する関数
  # 08_18_word-extract-docx-img-fun.R
extract_docx_imgs <- function(path) {
  docxs <- fs::dir_ls(path, regexp = "\\.docx$") # ワードの一覧
  zips <-
    docxs |>
    fs::path_file() |>         # ファイル名のみ
    fs::path_ext_set("zip") |> # 拡張子をzipに変更
    fs::path_temp()            # 一時ファイル
  fs::file_copy(docxs, zips, overwrite = TRUE) # docxをzipとして複製
  zip_dirs <- fs::path_ext_remove(zips)        # 拡張子の除去
  purrr::walk2(zips, zip_dirs, 
    \(x, y){ unzip(zipfile = x, exdir = y) })  # 解凍
  images <- purrr::map(zip_dirs, extract_imgs) # 画像の抽出
  images <- 
    unlist(images) |>
    fs::file_move(path) # 画像の移動
  return(images)
}
  # ディレクトリから画像を抽出する関数
  # 08_19_word-extract-img-fun.R
extract_imgs <- function(zip_dir) {
  img_dir <- fs::path(zip_dir, "word/media") # 画像ディレクトリ
  if(fs::dir_exists(img_dir)){               # ディレクトリの有無の確認
    img_files <- fs::dir_ls(img_dir)         # 画像ファイル
      # 変更後の画像ファイル
    img_files_new <- paste0(zip_dir, "_", fs::path_file(img_files))
      # 画像ファイルの複写
    fs::file_copy(img_files, img_files_new, overwrite = TRUE)
    return(img_files_new)
  }else{
    return(fs::path())
  }
}
  # 文字列や画像をまとめて入力する関数
  # 08_24_word-insert-fun.R
insert_texts <- function(docx, str, style = "Normal", ...){
  purrr::reduce(str, officer::body_add_par, 
                style = style, .init = docx, ...)
}
insert_images <- function(docx, images, width = 3, height = NULL, ...){
  size <- magick::image_read(images) |>
    magick::image_info() |> `[`(_, c("width", "height"))
  if(is.null(height)) height <- width * (size[[2]] / size[[1]])
  purrr::reduce(images, officer::body_add_img, 
                width = width, height = height, .init = docx, ...)
}
