  # fsパッケージのインストールと呼び出し
  # 01_01_file-install.R
install.packages("fs")
library(fs)

  # fsパッケージの関数一覧
  # 01_02_file-list.R
ls("package:fs") |> stringr::str_subset("^dir")
ls("package:fs") |> stringr::str_subset("^file") |> head()
ls("package:fs") |> stringr::str_subset("^path") |> head()

  # 作業ディレクトリの取得
  # 01_03_file-getwd.R
  # OSや使用状況などで表示は異なる
  # Windowsの場合は，USERNAMEにユーザ名が表示される
path_wd()
getwd() # 文字列としては同じ

  # 作業ディレクトリの設定
  # 01_04_file-setwd.R
wd <- "c:/NEW/DIRECOTORY"
setwd(wd)

  # fsパッケージのディレクトリを作業ディレクトリに設定
  # 01_05_file-setwd-pkg.R
wd <- path_package("fs")
wd
setwd(wd)

  # 一時パスの取得
  # 01_06_file-path-temp.R
path_temp()

  # ファイル名と拡張子を指定した一時パス
  # 01_07_file-file-temp.R
file_temp()
path_temp("hoge.txt")
file_temp(pattern = "example_", ext = "txt")

  # 作業用のディレクトリとファイルの生成
  # 01_08_file-create.R
dir_create("abc")
file_create(c("hoge.txt", "fuga.txt", "piyo.txt"))

  # ディレクトリ一覧の取得
  # 01_09_file-ls.R
dir_ls()
dir_ls(recurse = TRUE) # recurse = TRUEで下位ディレクトリも表示

  # `type`を指定したディレクトリ一覧の取得
  # 01_10_file-ls-type.R
dir_ls(type = "file") # ファイルのみ
dir_ls(type = "directory") # ディレクトリのみ

  # `path`を指定したディレクトリ一覧の取得
  # 01_11_file-ls-stringr.R
dir_ls(path = path_package("stringr"))

  # 作業ディレクトリでの一覧の取得
  # 01_12_file-ls-fullpath.R
dir_ls(path = path_wd(), type = "file")

  # 正規表現を使った一覧の取得
  # 01_13_file-regexp.R
dir_ls(type = "file", recurse = TRUE, regexp = "(doc|html)")

  # ディレクトリのツリー表示
  # 01_14_file-ls-tree.R
dirs <- dir_tree()
dirs
dir_tree(type = "directory") # ディレクトリのみ

  # `recurse`を指定したディレクトリのツリー表示
  # 01_15_file-ls-tree-recurse.R
dir_tree(recurse = 0) # 下位ディレクトリを表示しない
dir_tree(recurse = 1) # 1つ下位のディレクトリまで表示

  # ファイルとディレクトリ有無を取得
  # 01_16_file-exests.R
file_exists("DESCRIPTION")
file_exists("DESCRIPTIONS")
dir_exists("doc")
dir_exists("docs")

  # ディレクトリとファイルの詳細な情報の取得
  # 01_17_file-info.R
dir_info()

  # `dir_info()`と`stringr::detect()`を使ったファイルの絞り込み
  # 01_18_file-info-filter.R
dir_info() |>
  dplyr::filter(size > 10^3) |> # sizeが1000を超えるもの
  dplyr::filter(stringr::str_detect(path, "[A-G]")) # pathにA-Gを含むもの

  # 拡張子の設定
  # 01_19_file-ext-set.R
md_files <- dir_ls(type = "file", regexp = "\\.md$")
md_files
txt_file <- path_ext_set(md_files, "txt")
txt_file

  # 拡張子のみとファイル名のみの抽出
  # 01_20_file-ext.R
path_ext(md_files)
path_ext_remove(md_files)

  # 下位ディレクトリも対象とするとき
all_files <- dir_ls(type = "file", recurse = TRUE)
path_ext(all_files)
path_ext_remove(all_files)

  # 指定したディレクトリへのファイルの移動
  # 01_21_file-move.R
files <- c("hoge.txt", "fuga.txt", "piyo.txt")
files
result <- file_move(files, new_path = "abc")
result

  # 作業ディレクトリへのファイルの移動
  # 01_22_file-move-again.R
result <- file_move(result, new_path = ".")
result

  # ディレクトリ内でのファイルのコピー
  # 01_23_file-copy.R
copy_files <- stringr::str_c("copy_", files) # コピー後のファイル名
(file_copy(files, copy_files)) # 両端の()で結果を表示

  # 指定したディレクトリへのファイルのコピー
  # 01_24_file-copy-abc.R
(result <- file_copy(files, "abc"))  # 両端の()で結果を表示

  # ファイルのコピーでのエラー
  # 01_25_file-copy-error.R
file_copy(files, "abc") # 上書きできずエラー

  # ファイルの削除
  # 01_26_file-delete.R
(file_delete(copy_files))
(file_delete(result))

  # ファイル名の変更
  # 01_27_file-rename.R
(files <- dir_ls(regexp = "\\.txt$"))
(new_path <- c("foo.txt", "bar.txt", "baz.txt"))
(file_move(files, new_path))

  # 作業用のダミーファイルの生成
  # 01_28_file-rename-app-prep.R
paste0(letters[1:10], ".pdf") |>
  file_create()
shell.exec(path_wd()) # 作業ディレクトリを開く(Windowsのみ)

  # 複数のファイル名の変更例
  # 01_29_file-rename-files.R
old <- dir_ls(regexp = "\\.pdf$")
len <- length(old)
new <- 
  paste0(stringr::str_pad(1:len, width = 2, side = "left", pad = "0"), ".pdf")
file_move(old, new)

  # 作業用のダミーファイルの生成
  # 01_30_file-rename-info-prep.R
olds <- paste0(letters[1:10], ".xlsx")
for(old in sample(olds)){
  file_create(old)
  Sys.sleep(60)
}
shell.exec(path_wd()) # 作業ディレクトリを開く(Windowsのみ)

  # 更新時刻順に連番を付けるファイル名の変更例
  # 01_31_file-rename-info.R
files <- 
  dir_info(regexp = "\\.xlsx$") |>
  dplyr::arrange(modification_time) |> # modification_timeで並べ替え
  `$`(_, "path")  # _$pathと同じ
files
no <- 
  1:length(files) |>  # seq_along(files)でも同じ
  stringr::str_pad(width = 3, side = "left", pad = "0")
new_files <- stringr::str_c(no, "_", files)
new_files
file_move(files, new_files)

  # マウスでのファイルやディレクトリの指定
  # 01_32_file-tcltk.R
selected_file <- tcltk::tk_choose.files() # ファイルを指定する場合
  # ここでマウスによる操作
selected_file
selected_dir <- tcltk::tk_choose.dir() # ディレクトリを指定する場合
  # ここでマウスによる操作
selected_dir
setwd(selected_dir)
getwd()

  # 拡張子でファイルを整理する関数
  # 01_33_file-sort-fun.R
sort_files <- function(dir, show_tree = FALSE, ...){
  files <- fs::dir_ls(dir, type = "file", ...)         # ファイル一覧
  moves_to <- fs::path_ext(files)                      # 移動先
  dup <- fs::path_file(files) |> duplicated() |> any() # 重複の有無
  if(dup){                                             # 重複があれば
    stop("重複したファイル名があります")
  }
  sub_dirs <- unique(moves_to)                         # ディレクトリ一覧
  exists <- fs::dir_exists(fs::path(dir, sub_dirs))
  if(sum(exists) > 0){                                 # ディレクトリがあれば
    stop(fs::path(dir, sub_dirs)[exists], "は存在します")
  }
  purrr::walk(sub_dirs, fs::dir_create, path = dir)    # ディレクトリ作成
  res <- fs::file_move(files, fs::path(dir, moves_to)) # 移動
  if(show_tree){
    fs::dir_tree(dir)
  }
  return(res)
}

  # 拡張子でのファイルを整理(疑似コード)
  # 01_34_file-sort.R
sort_files("dir", show_tree = TRUE)

