  # メールの作成(複数対応)
  # 12_35_mail-ms365r-gen-emails-fun.R
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

