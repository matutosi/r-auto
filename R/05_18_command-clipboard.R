  # クリップボードの取り出し
  # 05_18_command-clipboard.R
passwd <- read.table("clipboard")[[1]] |>
  as.list()

