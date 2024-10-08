  # メールを自動作成・送信する関数
  # 12_16_mail-auto-gmails-fun.R
auto_gmails <- function(path){
  df <- 
    path |>
    readxl::read_xlsx(col_types = "text") |>
    tidyr::replace_na(list(cc = "", bcc = "", attachment = ""))
  gmails <- gen_gmails(df)
  if("send" %in% colnames(df)){
    draft <- gmails[df$send == "0"] |> # 下書きに保存
      purrr::map(gmailr::gm_create_draft)
    sent <- gmails[df$send == "1"] |> # 送信
      purrr::map(gmailr::gm_send_message)
  }
  return(list(sent = sent, draft = draft))
}

