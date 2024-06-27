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

