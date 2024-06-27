  # メールを自動送信する関数
  # 12_34_mail-ms365r-auto-emails-fun.R
auto_emails <- function(path, outlook){
  df <- readxl::read_xlsx(path)
  emails <- gen_emails(df, outlook)
  if("send" %in% colnames(df)){
    emails[df$send == 1] |>
      purrr::walk(function(x){ x$send()})
  }
  return(emails)
}

