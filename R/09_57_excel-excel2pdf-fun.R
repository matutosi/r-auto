  # エクセルをPDFに変換する関数
  # 09_57_excel-excel2pdf-fun.R
xlsx2pdf <- function(path){
  format_no <- 57                                         # PDFの番号
  path <- normalizePath(path)                             # Windows形式に変換
  converted <- 
    fs::path_ext_remove(path) |>                          # 拡張子除去
    normalizePath(mustWork = FALSE)
  xlsxApp <- RDCOMClient::COMCreate("Excel.Application")  # エクセルの操作
  xlsx <- xlsxApp$workbooks()$Open(path)                  # ファイルを開く
  xlsx$SaveAs(converted, FileFormat = format_no)          # 指定形式で保存
  xlsx$close()                                            # エクセルを閉じる
  converted <- fs::path_ext_set(converted, "pdf")         #  拡張子の設定
  return(converted)
}

