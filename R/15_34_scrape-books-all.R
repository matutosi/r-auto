  # 新刊情報の取得(まとめ)
  # 15_34_scrape-books-all.R
monthly_urls <- get_monthly_urls()
new_book_urls <-
  purrr::map(monthly_urls, get_new_book_urls) |> 
  unlist()
bk_details <- list()
for(i in seq_along(new_book_urls)){
  bk_details[[i]] <- 
    new_book_urls[i] |>
    get_book_html() |>
    detail2df()
}
bk_details <- dplyr::bind_rows(bk_details)
bk_details

