  # 更新時刻順に連番を付けるファイル名の変更例
  # 01_32_fs-rename-info.R
files <- 
  dir_info(regexp = "\\.xlsx$") |>
  dplyr::arrange(modification_time) |> # modification_timeで並べ替え
  `$`(_, "path")  # _$pathと同じ
files
no <- 
  1:length(files) |>  # seq_along(files)でも同じ
  stringr::str_pad(width = 3, pad = "0")
new_files <- stringr::str_c(no, "_", files)
new_files
file_move(files, new_files)

