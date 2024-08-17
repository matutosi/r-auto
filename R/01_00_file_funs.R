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
