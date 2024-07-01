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
combine_pdf <- function(){
  files <- fs::dir_ls(regexp = "\\.pdf$")
  choices <- gen_choices(files)
  prompt <- "結合するファイル番号を指定してください．\n例：2,5,1\n"
  file_no <- input_numbers(prompt, choices)
  files <- files[file_no]
  pdf_combine(files)
}
extract_images <- function(pdf, out = fs::path_temp(), bin_dir = ""){
  f_name <- 
    fs::path_file(pdf) |> # ファイル名のみ
    fs::path_ext_remove() # 拡張子の除去
  out_dir <- fs::path(out, f_name) # 出力ディレクトリ
  dir_create(out_dir)
  out_file <- fs::path(out_dir, f_name) # 出力ファイル
  bin <- "pdfimages"
  if(bin_dir != ""){
    bin <- fs::path(bin_dir, bin) # ディレクトリと実行ファイル
  }
  cmd <- paste0(bin, " -all ", pdf, " ", out_file) # 実行コマンド
  paste0("Runnning ", cmd) |> # 実行中の表示
    message()
  system(cmd, intern = TRUE) |> # コマンド実行
    iconv("sjis", "utf8") |> # 文字化け対策
    message()
  return(out_dir)
}
plot_page_number <- function(label, x_pos = width / 2, y_pos = 5,
gen_page_numbers <- function(n, x_pos = width / 2, y_pos = 5, 
add_page_numbers <- function(path, y_pos = 5, size = 5, 
