  # サンプルコードの保存
  # 03_09_shell-assoc-plot-save-rsc.R
code <- 
"# サンプルコード
path_pdf <- fs::path(fs::path_home(), 'plot.pdf')
pdf(path_pdf) # pdfデバイスを開く(baseでの方法)
plot(rnorm(100), rnorm(100)) # 散布図描画
dev.off() # デバイスを閉じる
shell.exec(path_pdf) # pdfを開く
"
path_rsc <- fs::path(fs::path_home(), "plot.rsc")
write(code, path_rsc) # コードの保存
shell.exec(fs::path_home()) # ホームディレクトリを開く
  # shell.exec(path_rsc) # Rコードの実行

