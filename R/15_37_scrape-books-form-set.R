  # フォームへの文字列の入力
  # 15_37_scrape-books-form-set.R
search <- rvest::html_form_set(form, keywords = "テキストマイニング")
search

