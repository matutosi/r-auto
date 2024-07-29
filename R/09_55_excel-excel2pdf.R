  # エクセルのPDFへの変換
  # 09_55_excel-excel2pdf.R
library(RDCOMClient)
path_pdf <- xlsx2pdf(file_timetable)
fs::path_file(path_pdf)

