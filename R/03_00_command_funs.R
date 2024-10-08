  # パスを通す関数(Windows用)
  # 03_02_command-add-path-fun.R
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
  path <- system(cmd, intern = TRUE)[3] |> # コマンド実行
          stringr::str_remove(" *path *REG_[A-z]* *") |> # 必要部分の取り出し
          double_quote()
  return(path)
}
double_quote <- function(x){
  paste0('"', x, '"') # 文字列をダブルクオートで囲む
}
  # ショートカットを作成する関数
  # 03_04_command-make-shortcut-fun.R
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
  # 関連付けアプリで開く関数
  # 03_06_command-exec-mac-fun.R
shell.exec <- function(file){
  cmd <- paste0("open ", file)
  system(cmd)
}
  # 秀丸エディタでファイルを開く関数
  # 03_12_command-hidemaru-fun.R
open_with_hidemaru <- function(file){
  bin <- '"c:/Program Files/hidemaru/hidemaru.exe"'
  cmd <- paste0(c(bin, file), collapse = " ")
  res <- system(cmd, wait = FALSE)
  return(ures)
}
  # zipファイルを解凍する関数
  # 03_14_command-unzip-fun.R
unzip_with_dir <- function(zip){
  dir <- fs::path_dir(zip)                    # ディレクトリ
  unzip_dir <- fs::path_file(zip)             # ファイル名
  unzip_dir <- fs::path_ext_remove(unzip_dir) # 拡張子除去
  unzip_dir <- fs::path(dir, unzip_dir)       # 解凍先ディレクトリ
  fs::dir_create(unzip_dir)                   # ディレクトリ生成
  utils::unzip(zip, exdir = unzip_dir)        # 解凍
  return(unzip_dir)
}
  # パスワード付きのzipファイルを解凍する関数
  # 03_16_command-unzip-pass-fun.R
unzip_with_password <- function(zip, passwd = "", bin_path = ""){
  dir <- fs::path_dir(zip)
  unzip_dir <- fs::path_file(zip) |>
               fs::path_ext_remove()                 # 拡張子除去
  unzip_dir <- fs::path(dir, unzip_dir) |> # 
               stringr::str_replace_all(" ", "_") |> # スペースを置換
               fs::dir_create()                      # ディレクトリ作成
  zip <- paste0('"', zip, '"')
  if(passwd == ""){
    passwd <- read.table("clipboard")[1,]            # クリップボードから
  }
  cmd <- paste0(bin_path, "7z x ", zip, " -p", passwd, " -o", unzip_dir)
  system(cmd)
  return(unzip_dir)
}
