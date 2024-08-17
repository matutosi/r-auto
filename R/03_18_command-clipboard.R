  # 複数のパスワード付きファイルの解凍(擬似コード)
  # 03_18_command-clipboard.R
passwd <- read.table("clipboard") |> unlist()
purrr::map2(zips, unzip_with_password, passwd)

