  # 比較結果のHTMLの設定ファイル
  # 05_20_string-css-path.R
path <- fs::path(fs::path_package("diffr"), 
                 "htmlwidgets/lib/codediff/codediff.css")
shell.exec(path)

