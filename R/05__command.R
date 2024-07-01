  # パスの通った場所の確認
  # 05_01_command-get-path.R
Sys.getenv("PATH") |>
  stringr::str_split_1(";") |>
  head(3)

  # パスを通す関数(Windows用)
  # 05_02_command-add-path-fun.R
add_path <- function(new_path){
  path <- get_user_path()
  path <- paste0(normalizePath(new_path), ";", path)
  cmd <- paste0("setx path ", path) # パス設定のdosコマンド
  res <- system(cmd, intern = TRUE) # コマンド実行
  message(iconv(res, "sjis", "utf8")) # 文字化け対策
  return(path)
}
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

  # パスを通す疑似コード
  # 05_03_command-add-path.R
add_path("c:/Users/USERNAME/shortcut") # 絶対パスで指定

  # remotesとautomaterのインストール
  # 05_04_install-automater.R
  # 2024-06-26時点ではインストールできません
install.packages("remotes")
remotes::install_github("matutosi/automater")

  # ショートカットを作成する関数
  # 05_05_command-make-shortcut-fun.R
  # ショートカットを作成する関数
  # とりあえず掲載しています．
make_shortcut <- function(exe, shortcut = NULL, dir = NULL,
                          arg = NULL, size = 1, wd = NULL){
  exe <- double_quote(exe)
  if(is.null(dir)){
    dir <- fs::path(Sys.getenv("USERPROFILE"), "shortcut")
    if(!fs::dir_exists(dir)){
      fs::dir_create(dir)
    }
  }else{
    if(!fs::dir_exists(dir)){
      stop("directory ", dir, " not found!")
    }
  }
  if(is.null(shortcut)){
    shortcut <- fs::path_file(exe)
  }
  shortcut <- 
    fs::path(dir, shortcut) %>%
    fs::path_ext_set("lnk") %>%
    double_quote()
  wsh    <- paste0("$WsShell = New-Object -ComObject WScript.Shell;")
  create <- paste0("$Shortcut = $WsShell.CreateShortcut(", shortcut, ");")
  target <- paste0("$Shortcut.TargetPath = ", exe, ";")
  icon   <- paste0("$Shortcut.IconLocation = ", exe, ";")
  size   <- paste0("$ShortCut.WindowStyle = ", size, ";")
  if(!is.null(arg)){ # command line arguments
    arg <- double_quote(arg)
    arg <- paste0("$ShortCut.Arguments = ", arg, ";")
  }
  if(!is.null(wd)){ # working directory
    wd <- double_quote(wd)
    wd <- paste0("$ShortCut.WorkingDirectory = ", wd, ";")
  }
  finish <- "$Shortcut.Save()"
  input <- paste0(wsh, create, target, icon, size, arg, wd, finish)
  cmd <- "powershell"
  res <- shell(cmd, input = input, intern = TRUE)
  shortcut <- stringr::str_remove_all(shortcut, "\"")
  return(list(shortcut = shortcut, res = res))
}

  # RとRStudioのショートカットを作成してパスを通す
  # 05_06_make-shortcut.R
  # RStudioのショートカット作成
  # パスが異なるときは適宜変更
# exe <- fs::path_home("Appdata/Local/Programs/RStudio/rstudio.exe")
exe <- 'C:/Progra~1/rstudio/rstudio.exe' # こちらの可能性あり
shortcut <- "rs"
wd <- fs::path_home("shortcut")
size <- 3
make_shortcut(exe, shortcut = shortcut, size = size, wd = wd)

  # Rのショートカット作成
  # パスが異なるときは適宜変更
exe <- fs::path(Sys.getenv("R_HOME"), "bin/x64/Rgui.exe")
shortcut <- "r"
 # --no-restore：環境を復元しない，--no-save：終了時に保存しない
 # --sdi：SDIで起動，--silent：起動時メッセージを出さない
arg <- "--no-restore --no-save --sdi --silent"
make_shortcut(exe, shortcut, arg = arg, size = size, wd = wd)

  # C:/Users/USERNAME/shortcut にパスを通す
new_path <- add_path(wd)

  # 関連付けアプリで開く関数
  # 05_07_command-exec-mac-fun.R
shell.exec <- function(file){
  cmd <- paste0("open ", file)
  system(cmd)
}

  # ワークブックをエクセルで開く
  # 05_08_command-exec-xlsx.R
path <- fs::path_temp("iris.xlsx")
wb <- openxlsx::write.xlsx(iris, path)
openxlsx::addFilter(wb, sheet = 1, rows = 1, cols = 1:5)
openxlsx::saveWorkbook(wb, path, overwrite = TRUE)
shell.exec(path)

  # URLからブラウザを起動
  # 05_09_command-exec-url.R
url <- "https://github.com/matutosi/r-auto"
shell.exec(url)

  # ホームディレクトリを開く
  # 05_10_command-exec-directory.R
home <- fs::path_home()
shell.exec(home)

  # 乱数の散布図をPDFで保存
  # 05_11_command-r-script-plot.R
path_pdf <- fs::path_home("desktop/plot.pdf")
pdf(path_pdf)                  # pdfデバイスを開く
  plot(rnorm(100), rnorm(100)) # 散布図の描画
dev.off()                      # デバイスを閉じる
shell.exec(path_pdf)           # PDFファイルを開く

  # 拡張子のないファイルをアプリを指定して起動
  # 05_12_command-system-rstudio-menu.R
  # 半角スペースがあるので文字列として「"」を含める
  # bin <- '"c:/Program..."' のシングルクオーテーション(')は
  #   ダブルクオーテーション(")と区別するため
bin <- '"c:/Program Files/hidemaru/hidemaru.exe"'
file <- fs::path(Sys.getenv("LOCALAPPDATA"), 
                 "RStudio/monitored/lists/project_mru")
cmd <- paste0(c(bin, file), collapse = " ")
system(cmd, wait = FALSE)

  # 秀丸エディタでファイルを開く関数
  # 05_13_command-hidemaru-fun.R
open_with_hidemaru <- function(file){
  bin <- '"c:/Program Files/hidemaru/hidemaru.exe"'
  cmd <- paste0(c(bin, file), collapse = " ")
  res <- system(cmd, wait = FALSE)
  res
}

  # 文字列の同一性確認
  # 05_14_command-quotation-identical.R
  # どちらも同じ文字列になる
double_quo <- "\"c:/Program Files/hidemaru/hidemaru.exe\""
single_quo <- '"c:/Program Files/hidemaru/hidemaru.exe"'
identical(double_quo, single_quo) # 同一性の確認

  # アプリの終了コマンド
  # 05_15_command-taskkill-win.R
fs::path(fs::path_home(), 'plot.pdf')
pdf(path_pdf)
  plot(rnorm(100), rnorm(100))
dev.off()
shell.exec(path_pdf) # pdfを開く
Sys.sleep(3) # 3秒待つ
cmd <- "taskkill /im Acrobat.exe" # コマンド
(res <- system(cmd, intern = TRUE)) # 実行
iconv(res, "sjis", "utf8") # 文字コード変換

  # zipファイルを解凍する関数
  # 05_16_command-unzip-fun.R
unzip_with_dir <- function(zip){
  dir <- fs::path_dir(zip)                    # ディレクトリ
  unzip_dir <- fs::path_file(zip)             # ファイル名
  unzip_dir <- fs::path_ext_remove(unzip_dir) # 拡張子除去
  unzip_dir <- fs::path(dir, unzip_dir)       # 解凍先ディレクトリ
  fs::dir_create(unzip_dir)                   # ディレクトリ生成
  utils::unzip(zip, exdir = unzip_dir)        # 解凍
  return(unzip_dir)
}

  # zipファイルの解凍
  # 05_17_command-unzip.R
dir_usr <- Sys.getenv("USERPROFILE")        # "c:/Users/USERNAME"
dsk <- fs::path(dir_usr, "Desktop")         # デスクトップのディレクトリ
zips <- fs::dir_ls(dsk, regexp = "\\.zip")  # zipファイル一覧
dirs <- purrr::map(zips, unzip_with_dir)    # 解凍
purrr::map(dirs, shell.exec)                # ディレクトリを開く

  # パスワード付きのzipファイルの解凍
  # 05_18_command-unzip-pass.R
unzip_with_password <- function(zip, passwd = "", bin_path = ""){
  dir <- fs::path_dir(zip)
  unzip_dir <- 
    fs::path_file(zip) |>
    fs::path_ext_remove() # 拡張子除去
  unzip_dir <- 
    fs::path(dir, unzip_dir) |> # 
    stringr::str_replace_all(" ", "_") |> # スペースを置換
    fs::dir_create() # ディレクトリ作成
  zip <- paste0('"', zip, '"')
  if(passwd == ""){
    passwd <- read.table("clipboard")[1,] # クリップボードから
  }
  cmd <- paste0(bin_path, "7z ", "x ", zip, " -p", passwd, " -o", unzip_dir)
  system(cmd)
  return(unzip_dir)
}
zips <- 
  fs::path_home("Desktop") |>
  fs::dir_ls(regexp = "\\.zip")
bin_path <- "c:/DIRECTORY/7zip/" # 要修正
dirs <- zips |>
  purrr::map(unzip_with_password, pass = "", bin_path = bin_path) # 解凍
purrr::map(dirs, shell.exec)     # ディレクトリを開く

  # クリップボードの取り出し
  # 05_19_command-clipboard.R
passwd <- read.table("clipboard")[[1]] |>
  as.list()

