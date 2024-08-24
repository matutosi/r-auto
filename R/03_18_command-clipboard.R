  # 複数のパスワード付きファイルの解凍(疑似コード)
  # 03_18_command-clipboard.R
passwd <- read.table("clipboard") |> unlist()
purrr::map2(zips, passwd, unzip_with_password)

