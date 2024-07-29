  # ファイルを添付する(複数対応)
  # 12_34_mail-ms365r-attach-files-fun.R
attach_files <- function(email, files){
  if(is.na(files) | files == ""){     # 添付ファイルなし
    return(invisible(email))
  }
  stringr::str_split_1(files, ",") |> # ,で分割
    purrr::walk(email$add_attachment) # ファイルを添付
  return(invisible(email))
}

