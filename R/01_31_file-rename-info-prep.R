  # 作業用のダミーファイルの生成
  # 01_31_file-rename-info-prep.R
olds <- paste0(letters[1:10], ".xlsx")
for(old in sample(olds)){
  file_create(old[i])
  Sys.sleep(60)
}
shell.exec(path_wd()) # 作業ディレクトリを開く(Windowsのみ)

