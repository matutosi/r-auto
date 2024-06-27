  # マウスでのファイルやディレクトリの指定
  # 01_33_file-tcltk.R
selected_file <- tcltk::tk_choose.files() # ファイルを指定する場合
  # ここでマウスによる操作
selected_file
  # デスクトップのhoge.xlsxというファイルを指定したとき
selected_dir <- tcltk::tk_choose.dir() # ディレクトリを指定する場合
  # ここでマウスによる操作
selected_dir
  # デスクトップを指定したとき
setwd(selected_dir)
getwd()

