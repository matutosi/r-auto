  # データフレームのエクセル形式での書き込み
  # 09_12_excel-write-df.R
file_wb <- fs::path_temp("workbook.xlsx")
write.xlsx(iris, file_wb)

