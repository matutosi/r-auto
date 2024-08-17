  # メールを自動送信する関数
  # 12_29_mail-ms365r-auto-emails-fun.R
auto_emails <- function(path, outlook){
  df <- readxl::read_xlsx(path)
  emails <- gen_emails(df, outlook)
  if("send" %in% colnames(df)){
    emails[df$send == 1] |>
      purrr::walk(\(x){ x$send() })
  }
  return(emails)
}

gen_emails <- function(df, outlook){
  cols <- c("to", "subject", "body", "cc", "bcc")
  emails <- 
    df |> 
    dplyr::select(dplyr::any_of(cols)) |> # 必要な列を選択
    purrr::pmap(outlook$create_email)     # メールを作成
  if("attachment" %in% colnames(df)){
    purrr::walk2(emails, df$attachment, attach_files)
  }
  return(emails)
}

attach_files <- function(email, files){
  if(is.na(files) | files == ""){     # 添付ファイルなし
    return(invisible(email))
  }
  stringr::str_split_1(files, ",") |> # ,で分割
    purrr::walk(email$add_attachment) # ファイルを添付
  return(invisible(email))
}

