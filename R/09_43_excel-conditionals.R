  # いろいろな条件付き書式設定の例
  # 09_43_excel-conditionals.R
val <- 1:10
str <- stringr::fruit[val]
df <- tibble::tibble(
  equal_3 = val, colourScale = val, databar = val, 
  top5 = val, bottom3 = val, 
  duplicates = letters[sample(1:9, 10, replace = TRUE)],
  beginsWith_a = str, endsWith_e = str, 
  contains_p = str, notContains_c = str)
file_cond <- fs::path_temp("conditional.xlsx")
write.xlsx(df, file_cond)
wb_cond <- loadWorkbook(file_cond)
rows <- 2:11
bg_style <- createStyle(bgFill = "green")
conditionalFormatting(wb_cond, 1, cols = 1, rows = rows,
  type = "expression", rule = "==3", style = bg_style)   # 3と同じ
conditionalFormatting(wb_cond, 1, cols = 2, rows = rows,
  type = "colourScale", style = c("white", "green"),     # カラースケール
  rule = c(0, 10))
conditionalFormatting(wb_cond, 1, cols = 3, rows = rows, 
  type = "databar", style = c("green"))                  # データバー
conditionalFormatting(wb_cond, 1, cols = 4, rows = rows,
  type = "topN", rank = 5, style = bg_style)             # 上位5つ
conditionalFormatting(wb_cond, 1, cols = 5, rows = rows,
  type = "bottomN", rank = 3, style = bg_style)          # 下位3つ
conditionalFormatting(wb_cond, 1, cols = 6, rows = rows,
  type = "duplicates", style = bg_style)                 # 重複
conditionalFormatting(wb_cond, 1, cols = 7, rows = rows,
  type = "beginsWith",  rule = "a", style = bg_style)    # aで始まる
conditionalFormatting(wb_cond, 1, cols = 8, rows = rows,
  type = "endsWith",    rule = "e", style = bg_style)    # eで終わる
conditionalFormatting(wb_cond, 1, cols = 9, rows = rows,
  type = "contains",    rule = "p", style = bg_style)    # pを含む
conditionalFormatting(wb_cond, 1, cols = 10, rows = rows,
  type = "notContains", rule = "c", style = bg_style)    # cを含まない
saveWorkbook(wb_cond, file_cond, overwrite = TRUE)

