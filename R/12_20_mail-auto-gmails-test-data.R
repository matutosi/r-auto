  # テストデータの作成
  # 12_20_mail-auto-gmails-test-data.R
path <- fs::path_temp("email.xlsx")
tibble::tibble(
  send = c("1", "0"),
  to = "matutosi@gmail.com",
  cc = "",
  bcc = "",
  subject = paste0("テストメール", 1:2),
  body = paste0("本文", 1:2),
  attachment = paste0(fs::path(fs::path_package("magick"), 
                      "images", c("man.gif", "building.jpg")), 
                      collapse = ",")) |>
  openxlsx::write.xlsx(path)

wb <- openxlsx::loadWorkbook(path)
openxlsx::setColWidths(wb, 1, cols = 1:7, widths = "auto") # 列幅
openxlsx::addFilter(wb, 1, cols = 1:7, rows = 1) # オートフィルタ
openxlsx::freezePane(wb, 1, firstRow = TRUE) # ウィンドウ枠
openxlsx::saveWorkbook(wb, path, overwrite = TRUE)

