  # ワークブックをエクセルで開く
  # 05_07_command-exec-xlsx.R
path <- fs::path_temp("iris.xlsx")
wb <- openxlsx::write.xlsx(iris, path)
openxlsx::addFilter(wb, sheet = 1, rows = 1, cols = 1:5)
openxlsx::saveWorkbook(wb, path, overwrite = TRUE)
shell.exec(path)

