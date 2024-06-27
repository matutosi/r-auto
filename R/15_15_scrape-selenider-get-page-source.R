  # ```{r scrape-selenider-get-page-source, eval = FALSE, subject = 'get_page_source(),read_html()', caption = ''}
  # 15_15_scrape-selenider-get-page-source.R
html <- get_page_source(session)
{html_document}
<html lang="ja">
[1] <head>\n<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">\n<meta charset="UTF-8">\n<title>HTMLの例</title>\n< ...
[2] <body>\n<div class="header">ヘッダーの部分\n  <a href="https://github.com/matutosi/r-auto">サポートページへ</a>\n</div>\n<hr>\n<div class="t ...
rvest::html_table(html) |>
  `[[`(_, 1)
  ##

