  # メール内を検索して表示する関数
  # 12_09_mail-gm-messages-show-fun.R
gm_show <- function(search = "", num_results = 3){
  msgs <- 
    gmailr::gm_messages(search = search, num_results = num_results) |>
    gmailr::gm_id() |>
    purrr::map(gmailr::gm_message)
  return(msgs)
}
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
  # 複数メールの作成
  # 12_17_mail-gen-gmails-fun.R
gen_gmails <- function(df){
  cols <- c("to", "cc", "bcc", "subject", "body")
  gmails <- 
    df |> 
    dplyr::select(dplyr::any_of(cols)) |> # 必要な列を選択
    purrr::pmap(gen_gmail)
  if("attachment" %in% colnames(df)){
    gmails <- purrr::map2(gmails, df$attachment, attach_files_gmail)
  }
  return(gmails)
}
  # 個別メールの作成
  # 12_18_mail-gen-gmail-fun.R
gen_gmail <- function(to, from, subject, body, cc, bcc){
  gmail <- 
    gmailr::gm_mime(to = to, cc = cc, bcc = bcc,
                    subject = subject, body = body)
  return(gmail)
}
  # ファイルを添付する(複数対応)
  # 12_19_mail-attach-files-fun.R
attach_files_gmail <- function(gmail, files){
  if(is.na(files) | files == ""){ # 添付ファイルなし
    return(gmail)
  }
  gmail <- 
    stringr::str_split_1(files, ",") |> # カンマで分割
    purrr::reduce(gmailr::gm_attach_file, .init = gmail)
  return(gmail)
}
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
