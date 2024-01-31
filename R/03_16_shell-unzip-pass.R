  # パスワード付きのzipファイルの解凍
  # 03_16_shell-unzip-pass.R
unzip_with_password <- function(zip, passwd = "", bin_path = ""){
  dir <- fs::path_dir(zip)
  unzip_dir <- fs::path_file(zip)
  unzip_dir <- fs::path_ext_remove(unzip_dir)
  unzip_dir <- fs::path(dir, unzip_dir)
  unzip_dir <- stringr::str_replace_all(unzip_dir, " ", "_")
  fs::dir_create(unzip_dir)
  zip <- paste0('"', zip, '"')
  if(passwd == ""){ passwd <- read.table("clipboard")[1,] }
  cmd <- paste0(bin_path, "7z ", "x ", zip, " -p", passwd, " -o", unzip_dir)
  system(cmd)
  return(unzip_dir)
}
zips <- 
  Sys.getenv("USERPROFILE") |>
  fs::path("Desktop") |>
  fs::dir_ls(regexp = "\\.zip")
bin_path <- "c:/DIRECTORY/7zip/" # 要修正
dirs <- purrr::map(zips, unzip_with_password, pass = "", bin_path = bin_path) # 解凍
purrr::map(dirs, shell.exec)     # ディレクトリを開く

