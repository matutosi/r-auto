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

