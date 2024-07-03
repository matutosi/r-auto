  # パスワード付きのzipファイルの解凍
  # 05_19_command-unzip-pass.R
zips <- 
  fs::path_home("Desktop") |>
  fs::dir_ls(regexp = "\\.zip")
bin_path <- "c:/DIRECTORY/7zip/" # 要修正
dirs <- zips |>
  purrr::map(unzip_with_password, pass = "", bin_path = bin_path) # 解凍
purrr::map(dirs, shell.exec)     # ディレクトリを開く

