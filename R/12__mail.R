  # gmailrのインストールと呼び出し
  # 12_01_mail-package.R
install.packages("gmailr")
library(gmailr) # 呼び出すと説明等が表示されます

  # 認証情報の読み込み
  # 12_02_mail-gm-auth-conf.R
gm_auth_configure(path = "oauth-client.json")
gm_oauth_client()

  # メールアドレスでの認証
  # 12_03_mail-gm-auth.R
gm_auth("YOURNAME@gmail.com")
  # Waiting for authentication in browser...
  # Press Esc/Ctrl + C to abort
  # Authentication complete.

  # アカウントの確認
  # 12_04_mail-gm-progile.R
gm_profile()
  # Logged in as:
  #   * email: YOURNAME@gmail.com
  #   * num_messages: 123456
  #   * num_threads: 78901

  # トークンの保存
  # 12_05_mail-gm-token-write.R
gm_token_write(path = "gmailr-token.rds")
fs::dir_ls(regexp = "rds") # 保存できたか確認
  # gmailr-token.rds

  # 再起動時のトークンの呼び出し
  # 12_06_mail-gm-token-read.R
library(gmailr)
token <- gm_token_read("gmailr-token.rds")
gm_auth(token = token)
gm_profile()
  # Logged in as:
  #   * email: YOURNAME@gmail.com
  #   * num_messages: 123456
  #   * num_threads: 78901

  # メールの表示
  # 12_07_mail-gm-threads.R
gm_threads(search = "検索文字列", num_results = 3)

  # Gmailの内容表示
  # 12_08_mail-gm-messages.R
messages <- gm_messages(search = "検索文字列", num_results = 3)
messages
gm_id(messages)[[1]]  |>
  gm_message()
gm_id(threads)[[1]]  |>
  gm_message()

  # メール内を検索して表示する関数
  # 12_09_mail-gm-messages-show-fun.R
gm_show <- function(search = "", num_results = 3){
  msgs <- 
    gmailr::gm_messages(search = search, num_results = num_results) |>
    gmailr::gm_id() |>
    purrr::map(gmailr::gm_message)
  return(msgs)
}

  # メールの内容を検索して表示
  # 12_10_mail-gm-messages-show.R
gm_show(search = "検索文字列", num_results = 3)

  # メールの作成
  # 12_11_mail-gm-email.R
gmail <-
  gm_mime() |>
  gm_to("hogehoge@gmail.com") |>
  gm_subject("テストメール1") |>
  gm_text_body("テストメールの本文．") |>
  gm_attach_file("photo.jpg") # 作業ディレクトリにphoto.jpgがある場合

  # メールの作成の別の方法
  # 12_12_mail-gm-mine.R
gmail <-
  gm_mime(to = "hogehoge@gmail.com",
          subject = "テストメール1",
          body = "テストメールの本文．", 
          attach_file = "photo.jpg")

  # メールの送信
  # 12_13_mail-gm-send-mail.R
gm_send_message(gmail)

  # 下書きへの保存
  # 12_14_mail-gm-messages-draft.R
draft <- gm_create_draft(gmail)

  # 下書きメールの送信
  # 12_15_mail-gm-messages-draft-send.R
gm_send_draft(draft)

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
  return(list(sent = sent, draft = draft)
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

  # テストデータの作成
  # 12_20_mail-auto-gmails-test-data.R
path <- fs::path_temp("email.xlsx")
tibble::tibble(
  send = c("1", "0"),
  to = "matutosi@gmail.com",
  cc = "",
  bcc = "",
  subject = paste0("テストメール", 1:2),
  body = paste0("本文", 1:2),
  attachment = paste0(fs::path(fs::path_package("magick"), 
                      "images", c("man.gif", "building.jpg")), 
                      collapse = ",")) |>
  openxlsx::write.xlsx(path)

wb <- openxlsx::loadWorkbook(path)
openxlsx::setColWidths(wb, 1, cols = 1:7, widths = "auto") # 列幅
openxlsx::addFilter(wb, 1, cols = 1:7, rows = 1) # オートフィルタ
openxlsx::freezePane(wb, 1, firstRow = TRUE) # ウィンドウ枠
openxlsx::saveWorkbook(wb, path, overwrite = TRUE)

  # メールの一斉送信
  # 12_21_mail-auto-gmails-generate.R
gmails <- auto_gmails(path = path)
gmails

  # 下書きメールの一斉送信
  # 12_22_mail-auto-drafts-send.R
gmails$draft |>
  purrr::walk(gm_send_draft)
  # 下書きを個別に送信するとき
  # gmails$draft[[1]] |>
  #   gm_send_draft()

  # 下書きメールの一斉削除
  # 12_23_mail-auto-drafts-delete.R
gm_drafts() |>
  gm_id() |>
  purrr::map(gm_delete_draft)

  # Microsoft365Rのインストールと呼び出し
  # 12_24_mail-ms365r-package.R
install.packages("Microsoft365R")
library(Microsoft365R)

  # Outlookでの認証
  # 12_25_mail-ms365r-get.R
 # outlook <- get_personal_outlook() # 個人用アカウント
outlook <- get_business_outlook() # 職場または学校アカウント

  # outlookの内容
  # 12_26_mail-ms365r-outlook.R
outlook
 ## <Outlook client for '甲南 花子'>
 ##   email address: yourname@outlook.co.jp
 ## ---
 ##   Methods:
 ##     create_email, create_folder, delete, delete_folder,
 ##     do_operation, get_deleted_items, get_drafts,
 ##     get_folder, get_inbox, get_list_pager,
 ##     get_sent_items, list_emails, list_folders,
 ##     sync_fields, update

  # メールの一覧取得
  # 12_27_mail-ms365r-list-emails.R
outlook$list_emails(n = 2) # メールを2つ表示

  # メールの作成と下書きの保存
  # 12_28_mail-ms365r-create-email.R
body <- "メールの本文.............."
body
 ## [1] "メールの本文.............."
em <- 
  outlook$create_email(
  body = body,
  content_type = "text", # "html"も可能
  subject = "メールの件名",
  to = "hogehoge@gmail.com", 
  cc = NULL, 
  bcc = NULL, 
  reply_to = NULL, 
  send_now = FALSE # FALSE：下書きに保存，TRUE：送信する
)
em # 作成したメールの内容
 ## <Outlook email>
 ##   directory id: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
 ##   from:
 ##   sent:
 ##   to: "hogehoge@gmail.com"
 ##   subject: メールの件名
 ## ---
 ## メールの本文..............

  # ファイルの添付
  # 12_29_mail-ms365r-add-attachment.R
em$add_attachment("添付ファイル名.xlsx")
em$list_attachments()
 ## [[1]]
 ## <Outlook email attachment '添付ファイル名.xlsx'>
 ##   directory id: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
 ##   attachment type: file 
 ##   attachment size: 128 

  # 下書きフォルダのメール一覧取得
  # 12_30_mail-ms365r-get-drafts.R
drafts <- outlook$get_drafts()$list_emails()
drafts
 ## [[1]]
 ## <Outlook email>
 ##   directory id: Axxxxxxxxxxxxxxxxxxxxxxxxxxxxx
 ##   from:
 ##   sent:
 ##   to: hogehoge@gmail.com
 ##   subject: メールの件名
 ## ---
 ## メールの本文..............
 ## 
 ## [[2]]
 ## <Outlook email>
 ## (省略)

  # メールの送信
  # 12_31_mail-ms365r-send-email.R
em$send() # メールの送信
  # drafts[[1]]$send() # これでも送信可能

  # メールを自動送信する関数
  # 12_32_mail-ms365r-auto-emails-fun.R
auto_emails <- function(path, outlook){
  df <- readxl::read_xlsx(path)
  emails <- gen_emails(df, outlook)
  if("send" %in% colnames(df)){
    emails[df$send == 1] |>
      purrr::walk(\(x){ x$send() })
  }
  return(emails)
}

  # メールの作成(複数対応)
  # 12_33_mail-ms365r-gen-emails-fun.R
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

  # メールの一斉送信
  # 12_35_mail-ms365r-auto-emails-generate.R
  # outlook <- get_personal_outlook() # 個人用アカウント
outlook <- get_business_outlook()     # 職場または学校アカウント
emails <- auto_emails(path = "email.xlsx", outlook)
emails

  # 下書きメールの一斉送信
  # 12_36_mail-ms365r-auto-drafts-send.R
outlook$get_drafts()$list_emails() |>
  purrr::map( \(x){ x$send() })

  # 下書きメールの一斉削除
  # 12_37_mail-ms365r-auto-drafts-delete.R
outlook$get_drafts()$list_emails() |>
  purrr::map( \(x){ x$delete(confirm = FALSE) })

