  # クリップボードの取り出し
  # 05_20_command-clipboard.R
passwd <- read.table("clipboard")[[1]] |>
  as.list()

