  # 新刊情報のページ一覧を取得
  # 15_27_scrape-monthly-urls.R
monthly_urls <- get_monthly_urls()
head(monthly_urls, 2)
  # shell.exex(monthly_urls[2]) # 1つ目のページを開く

