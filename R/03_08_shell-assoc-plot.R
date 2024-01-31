  # 散布図のpdfへの保存
  # 03_08_shell-assoc-plot.R
path_pdf <- fs::path(fs::path_home(), 'plot.pdf')
pdf(path_pdf) # pdfデバイスを開く(baseでの方法)
  plot(rnorm(100), rnorm(100)) # 散布図描画
dev.off() # デバイスを閉じる
shell.exec(path_pdf) # pdfを開く

