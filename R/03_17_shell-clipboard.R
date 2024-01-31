  # クリップボードの取り出し
  # 03_17_shell-clipboard.R
passwd <- read.table("clipboard")[[1]] |>
  as.list()

