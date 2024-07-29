  # 色々な条件付き書式設定の例
  # 09_43_excel-conditionals.R
val <- 1:10
str <- stringr::fruit[val]
df <- tibble::tibble(
  equal_3 = val, colourScale = val, databar = val, top5 = val, bottom3 = val, 
  duplicates = letters[sample(1:9, 10, replace = TRUE)],
  beginsWith_a = str, endsWith_e = str, contains_p = str, notContains_c = str)
file_cond <- fs::path_temp("conditional.xlsx")
write.xlsx(df, file_cond)
wb <- loadWorkbook(file_cond)
rows <- 2:11
conditionalFormatting(wb, 1, cols = 1, rows = rows,
  type = "expression", rule = "==3")                # 3と同じ
conditionalFormatting(wb, 1, cols = 2, rows = rows,
  type = "colourScale", style = c("blue", "white"), # カラースケール
  rule = c(0, 10))
conditionalFormatting(wb, 1, cols = 3, rows = rows,
  type = "databar", style = c("yellow"))            # データバー
conditionalFormatting(wb, 1, cols = 4, rows = rows,
  type = "topN", rank = 5)                          # 上位5つ
conditionalFormatting(wb, 1, cols = 5, rows = rows,
  type = "bottomN", rank = 3)                       # 下位3つ
conditionalFormatting(wb, 1, cols = 6, rows = rows,
  type = "duplicates")                              # 重複
conditionalFormatting(wb, 1, cols = 7, rows = rows,
  type = "beginsWith",  rule = "a")                 # aで始まる
conditionalFormatting(wb, 1, cols = 8, rows = rows,
  type = "endsWith",    rule = "e")                 # eで終わる
conditionalFormatting(wb, 1, cols = 9, rows = rows,
  type = "contains",    rule = "p")                 # pを含む
conditionalFormatting(wb, 1, cols = 10, rows = rows,
  type = "notContains", rule = "c")                 # cを含まない
saveWorkbook(wb, file_cond, overwrite = TRUE)

