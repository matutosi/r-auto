  # ディレクトリ内のPDFのうち指定したものを結合する関数
  # 07_12_pdf-combine-fun.R
combine_pdf <- function(){
  files <- fs::dir_ls(regexp = "\\.pdf$")
  choices <- gen_choices(files)
  prompt <- "結合するファイル番号を指定してください．\n例：2,5,1\n"
  file_no <- input_numbers(prompt, choices)
  files <- files[file_no]
  pdf_combine(files)
}

