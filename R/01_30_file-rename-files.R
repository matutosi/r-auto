  # 複数のファイル名の変更例
  # 01_30_file-rename-files.R
old <- dir_ls(regexp = "\\.pdf$")
len <- length(old)
new <- 
  paste0(stringr::str_pad(1:len, width = 2, side = "left", pad = "0"), ".pdf")
file_move(old, new)

