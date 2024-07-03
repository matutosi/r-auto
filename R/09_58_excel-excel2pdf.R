  # エクセルのPDFへの変換
  # 09_58_excel-excel2pdf.R
library(RDCOMClient)
path_pdf <- xlsx2pdf(file_timetable)
fs::path_file(path_pdf)
  # shell.exec(path_pdf)

