  # パスワード付きのzipファイルの解凍(疑似コード)
  # 03_17_command-unzip-pass.R
zips <- fs::path_home("Desktop") |>
        fs::dir_ls(regexp = "\\.zip")
bin_path <- "c:/DIRECTORY/7zip/" # 要設定
pass <- "パスワード"
dirs <- purrr::map(zips, unzip_with_password, pass, bin_path) # 解凍
purrr::map(dirs, shell.exec)     # ディレクトリを開く

