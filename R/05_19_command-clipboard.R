  # クリップボードの取り出し
  # 05_19_command-clipboard.R
passwd <- read.table("clipboard")[[1]] |>
  as.list()

