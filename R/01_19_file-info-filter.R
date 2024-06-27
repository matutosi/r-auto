  # `dir_info()`と`stringr::detect()`を使ったファイルの絞り込み
  # 01_19_file-info-filter.R
dir_info() |>
  dplyr::filter(size > 10^3) |> # sizeが1000を超えるもの
  dplyr::filter(stringr::str_detect(path, "[A-G]")) # pathにA-Gを含むもの

