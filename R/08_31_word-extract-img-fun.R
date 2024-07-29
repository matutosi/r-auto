  # ディレクトリから画像を抽出する関数
  # 08_31_word-extract-img-fun.R
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

