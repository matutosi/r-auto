  # ファイルを添付する(複数対応)
  # 12_20_mail-attach-files-fun.R
attach_files_gmail <- function(gmail, files){
  if(is.na(files) | files == ""){ # 添付ファイルなし
    return(gmail)
  }
  gmail <- 
    stringr::str_split_1(files, ",") |> # カンマで分割
    purrr::reduce(gmailr::gm_attach_file, .init = gmail)
  return(gmail)
}

