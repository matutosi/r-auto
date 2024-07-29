  # ヘッダーとフッターの設定
  # 09_44_excel-header.R
wb <- loadWorkbook(file_timetable)
header <- c("&[Date] &[Time]", "甲南女子大学の時間割", "&[File] &[Tab]")
footer <- c(NA, "&[Page] / &[Pages]", NA)
map_wb(wb, setHeaderFooter, header = header, footer = footer)
saveWorkbook(wb, file_timetable, overwrite = TRUE)

