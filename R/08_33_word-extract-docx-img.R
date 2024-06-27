  # ディクトリ内のワードから画像を抽出
  # 08_33_word-extract-docx-img.R
dir <- fs::dir_create(fs::path_temp(), "images") # ディレクトリの作成
fs::file_copy(c(path_doc_1, path_doc_2), dir)    # ファイルを複写
imgs <- extract_docx_imgs(dir)                   # ワードから画像を抽出
fs::path_file(imgs)                              # 抽出した画像のファイル名
 # shell.exec(dir)

