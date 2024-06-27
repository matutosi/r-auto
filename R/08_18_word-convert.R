  # ワードと各種形式との相互変換
  # 08_18_word-convert.R
library(RDCOMClient) # 無いと関数実行時にエラーが出る
path_pdf <- convert_docs(path_doc_1, "pdf")
fs::path_file(path_pdf)
  # shell.exec(path_pdf)

