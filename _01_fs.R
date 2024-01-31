  # fsパッケージのインストール
  # 01_01_fs-install.R
install.packages("fs")

  # fsパッケージの呼び出し
  # 01_02_fs-library.R
library(fs)

  # fsパッケージの関数一覧
  # 01_03_fs-list.R
  # install.packages("tidyverse") # tidyverseをインストールしていないとき
  # library(tidyverse) # tidyverseを呼び出していないとき
ls("package:fs") |> stringr::str_subset("^dir")
ls("package:fs") |> stringr::str_subset("^file")
ls("package:fs") |> stringr::str_subset("^path")

  # 作業ディレクトリの取得
  # 01_04_fs-getwd.R
  # OSや使用状況などで表示は異なります
  # Windowsの場合は，USERNAMEにユーザ名が表示されます
path_wd()
getwd() # 文字列としては同じ

  # 作業ディレクトリの設定
  # 01_05_fs-setwd.R
wd <- "c:/NEW/DIRECOTORY"
setwd(wd)

  # fsパッケージのディレクトリを作業ディレクトリに設定
  # 01_06_fs-setwd-pkg.R
wd <- path_package("fs")
wd
setwd(wd)

  # 一時パスの取得
  # 01_07_fs-path-temp.R
path_temp()

  # ファイル名と拡張子を指定した一時パス
  # 01_08_fs-file-temp.R
file_temp()
file_temp(pattern = "example_", ext = "txt")

  # 作業用のディレクトリとファイルの生成
  # 01_09_fs-create.R
dir_create("abc")
file_create(c("hoge.txt", "fuga.txt", "piyo.txt"))

  # ディレクトリ一覧の取得
  # 01_10_fs-ls.R
dir_ls()
dir_ls(recurse = TRUE) # recurse = TRUEで下位ディレクトリも表示

  # `type`を指定したディレクトリ一覧の取得
  # 01_11_fs-ls-type.R
dir_ls(type = "file") # ファイルのみ
dir_ls(type = "directory") # ディレクトリのみ

  # `path`を指定したディレクトリ一覧の取得
  # 01_12_fs-ls-stringr.R
dir_ls(path = path_package("stringr"))

  # 作業ディレクトリでの一覧の取得
  # 01_13_fs-ls-fullpath.R
dir_ls(path = path_wd(), type = "file")

  # 正規表現を使った一覧の取得
  # 01_14_fs-regexp.R
dir_ls(type = "file", recurse = TRUE, regexp = "\\.html$")

  # ディレクトリのツリー表示
  # 01_15_fs-ls-tree.R
dirs <- dir_tree()
dirs
dir_tree(type = "directory") # ディレクトリのみ

  # `recurse`を指定したディレクトリのツリー表示
  # 01_16_fs-ls-tree-recurse.R
dir_tree(recurse = 0) # 下位ディレクトリを表示しない
dir_tree(recurse = 1) # 1つ下位のディレクトリまで表示

  # ファイルとディレクトリ有無を取得
  # 01_17_fs-exests.R
dir_exists("DESCRIPTION")
dir_exists("DESCRIPTIONS")
dir_exists("doc")
dir_exists("docs")

  # ディレクトリとファイルの詳細な情報の取得
  # 01_18_fs-info.R
dir_info()

  # `dir_info()`と`stringr::detect()`を使ったファイルの絞り込み
  # 01_19_fs-info-filter.R
dir_info() |>
  dplyr::filter(size > 10^3) |> # sizeが1000を超えるもの
  dplyr::filter(stringr::str_detect(path, "[A-G]")) # pathにA-Gを含むもの

  # 拡張子の設定
  # 01_20_fs-ext-set.R
md_files <- dir_ls(type = "file", regexp = "\\.md$")
md_files
txt_file <- path_ext_set(md_files, "txt")
txt_file

  # 拡張子のみとファイル名のみの抽出
  # 01_21_fs-ext.R
path_ext(md_files)
path_ext_remove(md_files)

  # 下位ディレクトリも対象とするとき
all_files <- dir_ls(type = "file", recurse = TRUE)
path_ext(all_files)
path_ext_remove(all_files)

  # 指定したディレクトリへのファイルの移動
  # 01_22_fs-move.R
files <- c("hoge.txt", "fuga.txt", "piyo.txt")
files
result <- file_move(files, new_path = "abc")
result
  # abc/hoge.txt abc/fuga.txt abc/piyo.txt

  # 作業ディレクトリへのファイルの移動
  # 01_23_fs-move-again.R
result <- file_move(result, new_path = ".")
result

  # ディレクトリ内でのファイルのコピー
  # 01_24_fs-copy.R
copy_files <- stringr::str_c("copy_", files) # コピー後のファイル名
(file_copy(files, copy_files)) # 両端の()で結果を表示

  # 指定したディレクトリへのファイルのコピー
  # 01_25_fs-copy-abc.R
(result <- file_copy(files, "abc"))  # 両端の()で結果を表示

  # ファイルのコピーでのエラー
  # 01_26_fs-copy-error.R
file_copy(files, "abc") # 上書きできずエラー

  # ファイルの削除
  # 01_27_fs-delete.R
(file_delete(copy_files))
(file_delete(result))

  # ファイル名の変更
  # 01_28_fs-rename.R
(files <- dir_ls(regexp = "\\.txt$"))
(new_path <- c("foo.txt", "bar.txt", "baz.txt"))
new_path
(file_move(files, new_path))

  # 作業用のダミーファイルの生成
  # 01_29_fs-rename-app-prep.R
paste0(letters[1:10], ".pdf") |>
  file_create()
shell.exec(path_wd()) # 作業ディレクトリを開く(Windowsのみ)

  # 複数のファイル名の変更例
  # 01_30_fs-rename-files.R
old <- dir_ls(regexp = "\\.pdf$")
len <- length(old)
new <- paste0(stringr::str_pad(1:len, width = 2, pad = "0"), ".pdf")
file_move(old, new)

  # 作業用のダミーファイルの生成
  # 01_31_fs-rename-info-prep.R
olds <- paste0(letters[1:10], ".xlsx")
for(old in sample(olds)){
  file_create(old[i])
  Sys.sleep(60)
}
shell.exec(path_wd()) # 作業ディレクトリを開く(Windowsのみ)

  # 更新時刻順に連番を付けるファイル名の変更例
  # 01_32_fs-rename-info.R
files <- 
  dir_info(regexp = "\\.xlsx$") |>
  dplyr::arrange(modification_time) |> # modification_timeで並べ替え
  `$`(_, "path")  # _$pathと同じ
files
no <- 
  1:length(files) |>  # seq_along(files)でも同じ
  stringr::str_pad(width = 3, pad = "0")
new_files <- stringr::str_c(no, "_", files)
new_files
file_move(files, new_files)

  # マウスでのファイルやディレクトリの指定
  # 01_33_fs-tcltk.R
selected_file <- tcltk::tk_choose.files() # ファイルを指定する場合
  # ここでマウス操作
selected_file
  # デスクトップのhoge.xlsxというファイルを指定したとき
selected_dir <- tcltk::tk_choose.dir() # ディレクトリを指定する場合
  # ここでマウス操作
selected_dir
  # デスクトップを指定したとき
setwd(selected_dir)
getwd()

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

