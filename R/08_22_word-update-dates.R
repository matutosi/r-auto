  # ワードの文書内の日付の修正
  # 08_22_word-update-dates.R
text <- extract_docx_text(doc_1) # 文字列の抽出
dates_before <- # 日付の抽出
  extract_date_ish(text) |>
  unlist()
dates_after <- update_wday(dates_before)  # 正しい曜日
tibble::tibble(dates_before, dates_after) # 置換文字列の一覧
doc_1 <- 
  purrr::reduce2(.x = dates_before, .y = dates_after, 
                 .f = body_replace_all_text, .init = doc_1, fixed = TRUE)
print(doc_1, path_doc_1)
  # shell.exec(path_doc_1)
  # forループのとき
  # for(i in 1:length(dates_before)){
  #   docx_1 <- docx_1 |>
  #     body_replace_all_text(dates_before[i], dates_after[i], fixed = TRUE)
  # }

