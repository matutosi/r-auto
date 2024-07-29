  # fsパッケージの関数一覧
  # 01_02_file-list.R
ls("package:fs") |> stringr::str_subset("^dir")
ls("package:fs") |> stringr::str_subset("^file") |> head()
ls("package:fs") |> stringr::str_subset("^path") |> head()

