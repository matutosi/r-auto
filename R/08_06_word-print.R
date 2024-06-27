  # 文書の書き出し
  # 08_06_word-print.R
path_doc_2 <- fs::path_temp("doc_2.docx")
print(x = doc_1, target = path_doc_2)
  # shell.exec(path_doc_2)

