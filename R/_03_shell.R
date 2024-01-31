  # パスの通った場所の確認
  # 03_01_shell-get-path.R
Sys.getenv("PATH") |>
  stringr::str_split_1(";") |>
  unique() |>
  sort() |> 
  head()

  # パスを通す関数
  # 03_02_shell-set-path.R
get_user_path <- function(){
   # レジストリエディタでパスを取得するコマンド
  cmd <- 'reg query "HKEY_CURRENT_USER\\Environment" /v "path"'
  path <- 
    system(cmd, intern = TRUE)[3] |> # コマンド実行
    stringr::str_remove(" *path *REG_[A-z]* *") |> # 必要部分の取り出し
    double_quote()
  return(path)
}
double_quote <- function(x){
  paste0('"', x, '"') # 文字列をダブルクオートで囲む
}
#' @examples
#' add_path("c:/Users/USERNAME/shortcut")  # 絶対パスで指定
add_path <- function(new_path){
  path <- get_user_path()
  path <- paste0(normalizePath(new_path), ";", path)
  cmd <- paste0("setx path ", path) # パス設定のdosコマンド
  res <- system(cmd, intern = TRUE) # コマンド実行
  message(iconv(res, "sjis", "utf8")) # 文字化け対策
  return(path)
}

  # ```{r make_shortcut, eval = FALSE, subject = 'Sys.getenv()', caption ='RとRStudioのショートカットを作成してパスを通す'}
  # 03_03_make_shortcut.R
  # RStudioのショートカット作成
  # パスが異なるときは適宜変更
exe <- fs::path(Sys.getenv("LOCALAPPDATA"), "Programs/RStudio/rstudio.exe")
shortcut <- "rs"
wd <- Sys.getenv("R_USER")
size = 3
res <- automater::make_shortcut(exe, shortcut = shortcut, size = size, wd = wd)

  # Rのショートカット作成
  # パスが異なるときは適宜変更
exe <- fs::path(Sys.getenv("R_HOME"), "bin/x64/Rgui.exe")
shortcut <- "r"
 # --no-restore：環境を復元しない，--no-save：終了時に保存しない
 # --sdi：SDIで起動，--silent：起動時メッセージを出さない
arg <- "--no-restore --no-save --sdi --silent"
wd <- Sys.getenv("R_USER")
size = 3
res <- automater::make_shortcut(exe, shortcut = shortcut, arg = arg, size = size, wd = wd)
  # C:/Windows/USERNAME/shortcut にパスを通す
new_path <- 
  fs::path_dir(res$shortcut) |>
  automater::add_path()

  # 関連付けファイルで開く関数
  # 03_04_shell-exec-mac-fun.R
#' @params path A string of for file name
#' @examples
#' shell_open("sample.txt")
shell_open <- function(path){
  cmd <- paste0("open ", path)
  system(cmd)
}

  # ワークブックをエクセルで開く
  # 03_05_shell-exec-xlsx.R
path <- fs::path_temp("iris.xlsx")
wb <- openxlsx::write.xlsx(iris, path)
openxlsx::addFilter(wb, sheet = 1, rows = 1, cols = 1:5)
openxlsx::saveWorkbook(wb, path, overwrite = TRUE)
shell.exec(path) # Windows
  # shell_open(path) # Mac / Ubuntu

  # URLからブラウザを起動
  # 03_06_shell-exec-url.R
url <- "https://github.com/matutosi/r-auto"
shell.exec(url) # Windows
  # shell_open(url) # Mac / Ubuntu

  # ホームディレクトリを開く
  # 03_07_shell-exec-directory.R
home <- fs::path_home()
shell.exec(home) # Windows
  # shell_open(home) # Mac / Ubuntu

  # 散布図のpdfへの保存
  # 03_08_shell-assoc-plot.R
path_pdf <- fs::path(fs::path_home(), 'plot.pdf')
pdf(path_pdf) # pdfデバイスを開く(baseでの方法)
  plot(rnorm(100), rnorm(100)) # 散布図描画
dev.off() # デバイスを閉じる
shell.exec(path_pdf) # pdfを開く

  # サンプルコードの保存
  # 03_09_shell-assoc-plot-save-rsc.R
code <- 
"# サンプルコード
path_pdf <- fs::path(fs::path_home(), 'plot.pdf')
pdf(path_pdf) # pdfデバイスを開く(baseでの方法)
plot(rnorm(100), rnorm(100)) # 散布図描画
dev.off() # デバイスを閉じる
shell.exec(path_pdf) # pdfを開く
"
path_rsc <- fs::path(fs::path_home(), "plot.rsc")
write(code, path_rsc) # コードの保存
shell.exec(fs::path_home()) # ホームディレクトリを開く
  # shell.exec(path_rsc) # Rコードの実行

  # シェルスクリプトの保存
  # 03_10_shell-assoc-plot-save-sh.R
code <- 
"#! /bin/bash
/usr/local/bin/Rscript ~/plot.R"
path_sh <- fs::path(fs::path_home(), "plot.sh")
write(code, path_sh)
  # shell_open(path_sh) # Rコードを開く

  # 実行権限の付与
  # 03_11_shell-assoc-plot-chmod.R
fs::file_chmod(path_sh, "u+x")

  # アプリの終了コマンド
  # 03_12_shell-taskkill-win.R
fs::path(fs::path_home(), 'plot.pdf')
pdf(path_pdf)
  plot(rnorm(100), rnorm(100))
dev.off()
shell.exec(path_pdf) # pdfを開く
Sys.sleep(3) # 3秒待つ
cmd <- "taskkill /im Acrobat.exe" # コマンド
(res <- system(cmd, intern = TRUE)) # 実行
iconv(res, "sjis", "utf8") # 文字コード変換

  # 拡張子のないファイルをアプリを指定して起動
  # 03_13_shell-system-rstudio-menu.R
  # 半角スペースがあるので文字列として「"」を含める
  # シングルクオーテーション(')はダブルクオーテーション(")と区別するため
bin <- '"c:/Program Files/hidemaru/hidemaru.exe"'
  # bin <- '"d:/pf/hidemaru/hidemaru.exe"'
file <- fs::path(Sys.getenv("LOCALAPPDATA"), 
                 "RStudio/monitored/lists/project_mru")
cmd <- paste0(c(bin, file), collapse = " ")
res <- system(cmd, wait = FALSE)
res

  # 文字列の同一性確認
  # 03_14_shell-quotation-identical.R
  # どちらも同じ文字列になる
double_quo <- "\"c:/Program Files/hidemaru/hidemaru.exe\""
single_quo <- '"c:/Program Files/hidemaru/hidemaru.exe"'
identical(double_quo, single_quo) # 同一性の確認

  # zipファイルの解凍
  # 03_15_shell-unzip.R
#' @params zip A string for full path of a zip file.
unzip_with_dir <- function(zip){
  dir <- fs::path_dir(zip)                    # ディレクトリ
  unzip_dir <- fs::path_file(zip)             # ファイル名
  unzip_dir <- fs::path_ext_remove(unzip_dir) # 拡張子除去
  unzip_dir <- fs::path(dir, unzip_dir)       # 解凍先ディレクトリ
  fs::dir_create(unzip_dir)                   # ディレクトリ生成
  utils::unzip(zip, exdir = unzip_dir)        # 解凍
  return(unzip_dir)
}
dir_usr <- Sys.getenv("USERPROFILE")        # "c:/Users/USERNAME"
dsk <- fs::path(dir_usr, "Desktop")         # デスクトップのディレクトリ
zips <- fs::dir_ls(dsk, regexp = "\\.zip")  # zipファイル一覧
dirs <- purrr::map(zips, unzip_with_dir)    # 解凍
purrr::map(dirs, shell.exec)                # ディレクトリを開く

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

  # クリップボードの取り出し
  # 03_17_shell-clipboard.R
passwd <- read.table("clipboard")[[1]] |>
  as.list()

