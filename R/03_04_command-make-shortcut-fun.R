  # ショートカットを作成する関数
  # 03_04_command-make-shortcut-fun.R
make_shortcut <- function(exe, shortcut = NULL, dir = NULL,
                          arg = NULL, size = 1, wd = NULL){
  exe <- double_quote(exe)
  if(is.null(dir)){ # ショートカットを保存するディレクトリ
    dir <- fs::path(Sys.getenv("USERPROFILE"), "shortcut")
    if(!fs::dir_exists(dir)){
      fs::dir_create(dir)
    }
  }else{
    if(!fs::dir_exists(dir)){
      stop("directory ", dir, " not found!")
    }
  }
  if(is.null(shortcut)){ # ショートカットのファイル名(拡張子は含まない)
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
  size   <- paste0("$ShortCut.WindowStyle = ", size, ";") # 1:通常，3:最大化，7：最小化
  if(!is.null(arg)){ # コマンドライン引数
    arg <- double_quote(arg)
    arg <- paste0("$ShortCut.Arguments = ", arg, ";")
  }
  if(!is.null(wd)){ # ショートカットにおける作業ディレクトリ
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

