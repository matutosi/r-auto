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

