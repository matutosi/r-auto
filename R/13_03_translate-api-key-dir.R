  # ユーザのドキュメントのディレクトリを開く
  # 13_03_translate-api-key-dir.R
fs::path(Sys.getenv("HOME")) |> # c:\Users\USERNAME\Documents
  shell.exec() # ディレクトリを開く

