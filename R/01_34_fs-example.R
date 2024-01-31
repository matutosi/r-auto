  # Rバージョンアップ時のRconsole等の複製
  # 01_34_fs-example.R
  # Rバージョンアップ時のRconsole等の複製スクリプト
wd <- 
  fs::path_package("base") |>
  fs::path_split() |>
  unlist()
  # wd # "D:/R"に"R-4.3.1"がインストールされている場合に4.3.1で実行
wd <- 
  wd[-c((length(wd) - 2):length(wd))] |>
  fs::path_join()
  # wd
setwd(wd) # 作業ディレクトリの設定
dir <- fs::dir_ls(type = "directory")
  # dir # 複数のRがインストールされている
d_old <- dir[length(dir)-1] # 最新から1つ前のバージョンのディレクトリ
d_new <- dir[length(dir)]   # 最新のバージョン
files <- c("Rconsole", "Rprofile.site")  # コピーするファイル
f_new <- fs::path(d_new, "etc")
f_old <- fs::path(d_old, "etc", files)
fs::file_copy(f_old, f_new, overwrite = TRUE)

