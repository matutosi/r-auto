  # パスの通った場所の確認
  # 03_01_command-get-path.R
Sys.getenv("PATH") |>
  stringr::str_split_1(";") |>
  head(3)

