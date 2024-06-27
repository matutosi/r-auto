  # 新刊の詳細情報の取得
  # 15_35_scrape-books-write-xlsx.R
bk_xlsx <- fs::path_temp("book.xlsx")
openxlsx::write.xlsx(bk_details, bk_xlsx)
  # shell.exec(bk_xlsx)

