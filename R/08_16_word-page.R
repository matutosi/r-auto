  # ページ設定
  # 08_16_word-page.R
size <- page_size(orient = "landscape") # 横向き
mar <- 0.4                              # 1インチ：約1cm
margins <- page_mar(mar, mar, mar, mar, # 順に下上右左の余白
                    mar/2, mar/2,       # ヘッダーとフッターの位置
                    0)                  # 綴じ代
ps <- prop_section(page_size = size, page_margins = margins)
doc_1 <- body_set_default_section(doc_1, value = ps)
print(x = doc_1, target = path_doc_1)

