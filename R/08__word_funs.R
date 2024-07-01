  # ワードから文字列を抽出する関数
  # 08_10_word-docx-extract-text-fun.R
extract_docx_text <- function(docx, normal = TRUE, heading = TRUE, flatten = TRUE){
  if(sum(normal, heading) == 0){ # 両方ともFALSEのとき
    return("") # ""を返す
  }
  condtion <- # 検索条件："normal|heading", "normal", "heading" のうち1つ
    c("Normal"[normal], "heading"[heading]) |>
    paste0(collapse = "|")
  text <- # 文字列
    docx |>
    officer::docx_summary() |>
    dplyr::filter(stringr::str_detect(style_name, condtion)) |>
    dplyr::filter(text != "") |>
    dplyr::select(text)
  if(flatten) text <- text$text
  return(text)
}
  # ワードと各種形式との相互変換の関数
  # 08_17_word-convert-fun.R
convert_docs <- function(path, format){
  if (fs::path_ext(path) == format){ # 拡張子が入力と同じとき
    return(invisible(path))          # 終了
  }
  format_no <- switch(format,        # 拡張子ごとに番号に変換
                      docx = 16, pdf = 17,
                      xps = 19, html = 20, rtf = 23, txt = 25)
  path <- normalizePath(path)        # Windowsの形式に変換
  converted <- 
    fs::path_ext_set(path, ext = format) |> # 変換後の拡張子
    normalizePath(mustWork = FALSE)
  # ワードの操作
  wordApp <- RDCOMClient::COMCreate("Word.Application")
  wordApp[["Visible"]] <- FALSE            # TRUE：ワードの可視化
  wordApp[["DisplayAlerts"]] <- FALSE      # TRUE：警告の表示
  doc <- wordApp[["Documents"]]$Open(path, # ファイルを開く
                                     ConfirmConversions = FALSE)
  doc$SaveAs2(converted, FileFormat = format_no) # 名前をつけて保存
  doc$close()
  return(converted)
}
  # 文字列をまとめて入力する関数
  # 08_22_word-insert-text-fun.R
insert_text <- function(docx, str, style = "Normal"){
  docx <- 
    str |> # strを順番に
    purrr::reduce(officer::body_add_par, style = style, .init = docx)
  return(docx)
}
  # 文字列を比較して異なるときのみ貼り付ける関数
  # 08_30_word-cumulative-paste-fun.R
cumulative_paste <- function(x, y){
  if(x == y){    # xとyが同じなら
    x            #   xのまま
  }else{         # xとyが異なれば
    paste0(x, y) #   xとyを貼り付け
  }
}
  # ディクトリ内のワードから画像を抽出する関数
  # 08_32_word-extract-docx-img-fun.R
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
  # 08_33_word-extract-img-fun.R
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
