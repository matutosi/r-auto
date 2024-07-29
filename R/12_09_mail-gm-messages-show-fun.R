  # メール内を検索して表示する関数
  # 12_09_mail-gm-messages-show-fun.R
gm_show <- function(search = "", num_results = 3){
  msgs <- 
    gmailr::gm_messages(search = search, num_results = num_results) |>
    gmailr::gm_id() |>
    purrr::map(gmailr::gm_message)
  return(msgs)
}

