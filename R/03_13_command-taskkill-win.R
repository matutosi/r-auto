  # アプリの終了コマンド
  # 03_13_command-taskkill-win.R
path_pdf <- fs::path(fs::path_home(), 'plot.pdf')
pdf(path_pdf)
  plot(rnorm(100), rnorm(100))
dev.off()
shell.exec(path_pdf) # pdfを開く
Sys.sleep(3)         # 3秒待つ
cmd <- "taskkill /im Acrobat.exe"   # 終了コマンド
(res <- system(cmd, intern = TRUE)) # 実行
iconv(res, "sjis", "utf8")          # 文字コード変換

