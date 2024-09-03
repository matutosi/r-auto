  # マウスでのファイルやディレクトリの指定
  # 01_32_file-tcltk.R
selected_file <- tcltk::tk_choose.files() # ファイルを指定する場合
  # ここでマウスによる操作
selected_file
selected_dir <- tcltk::tk_choose.dir() # ディレクトリを指定する場合
  # ここでマウスによる操作
selected_dir
setwd(selected_dir)
getwd()

