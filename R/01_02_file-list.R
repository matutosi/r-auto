  # fsパッケージの関数一覧
  # 01_02_file-list.R
ls("package:fs") |> stringr::str_subset("^dir")            # ディレクトリ操作
ls("package:fs") |> stringr::str_subset("^file") |> head() # ファイル操作
ls("package:fs") |> stringr::str_subset("^path") |> head() # パス操作

