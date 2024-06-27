  # 乱数の散布図をPDFで保存
  # 05_11_command-r-script-plot.R
path_pdf <- fs::path_home("desktop/plot.pdf")
pdf(path_pdf)                  # pdfデバイスを開く
  plot(rnorm(100), rnorm(100)) # 散布図の描画
dev.off()                      # デバイスを閉じる
shell.exec(path_pdf)           # PDFファイルを開く

