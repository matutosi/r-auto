  # 複数のPDFファイルからファイルを選択して分割する関数
  # 07_08_pdf-subset-fun.R
subset_pdf <- function(){
  # ファイルの選択
  files <- fs::dir_ls(regexp = "\\.pdf$") # PDFファイルの一覧取得
  if(length(files) == 0){
    message("PDFファイルがありません")
    return(0)
  }
  if(length(files) > 1){
    choices <- gen_choices(files) # ファイルを選択肢に
    prompt <- "分割するPDFファイルを選択してください\n"
    file_no <- input_numbers(prompt, choices)
    selected_files <- files[file_no]
  }
  # ページの抽出
  res <- list()
  for(file in selected_files){
    shell.exec(file)
    len <- pdf_length(file)
    prompt <- 
      paste0("ファイル名：", file, "\n",
             "ページ番号を指定してください．\n例：1,3,5-10\n",
             "最大ページ数：", len, "\n")
    pages <- input_numbers(prompt)
    res[[file]] <- pdftools::pdf_subset(file, pages)
  }
  return(res)
}

