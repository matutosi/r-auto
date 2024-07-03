  # 複数のPDFファイルからファイルを選択して分割する関数
  # 07_10_pdf-subset-fun.R
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
  # ディレクトリ内のPDFのうち指定したものを結合する関数
  # 07_13_pdf-combine-fun.R
combine_pdf <- function(){
  files <- fs::dir_ls(regexp = "\\.pdf$")
  choices <- gen_choices(files)
  prompt <- "結合するファイル番号を指定してください．\n例：2,5,1\n"
  file_no <- input_numbers(prompt, choices)
  files <- files[file_no]
  pdf_combine(files)
}
  # PDFに含まれる画像を抽出する関数
  # 07_21_pdf-extract-images-fun.R
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
  # ページ番号だけのページを作成する関数
  # 07_23_pdf-plot-page-number.R
plot_page_number <- function(label, x_pos = width / 2, y_pos = 5,
                             size = 5, colour = "black", 
                             width = 210, height = 297, ...){
  tibble::tibble(x_pos = x_pos, y_pos = y_pos, label = label) |>
  ggplot2::ggplot(ggplot2::aes(x_pos, y_pos, label = label)) +
    ggplot2::geom_text(size = size, colour = colour, ...) + # ページ数の描画
    # x軸とy軸の設定
    ggplot2::scale_x_continuous(limits = c(0, width) , expand = c(0, 0)) + 
    ggplot2::scale_y_continuous(limits = c(0, height), expand = c(0, 0)) + 
    ggplot2::theme_void()
}
  # 複数ページ分のページ番号のPDFを生成する関数
  # 07_24_pdf-gen-page-numbers-fun.R
gen_page_numbers <- function(n, x_pos = width / 2, y_pos = 5, 
                             size = 5, colour = "black", 
                             width = 210, height = 297, ...){
  pages <- seq(n)
  filename <- fs::path_temp(paste0(pages, ".pdf"))
  page_numbers <- 
    purrr::map(pages, plot_page_number,  # ページごとで繰り返し
               x_pos = x_pos, y_pos = y_pos, 
               size = size, colour = colour, 
               width = width, height = height, ...)
  purrr::walk2( # ページごとにファイルを書き込み
    filename, page_numbers, 
    ggplot2::ggsave, 
      width = width, height = height, units ="mm", bg = "transparent")
  return(unlist(filename))
}
  # ページ番号を重ね合わせる関数
  # 07_26_pdf-add-page-numbers-fun.R
add_page_numbers <- function(path, y_pos = 5, size = 5, 
                             colour = "black", backside = FALSE, ...){
  pdf_spl <- pdftools::pdf_split(path) # 分割
  n <- length(pdf_spl) # PDFのページ数
  pdf_pages <- 
    gen_page_numbers(n = n, y_pos = y_pos, # ページ番号のPDF生成
                     size = size, colour = colour, ...)
  if(backside){ # 上下入れ替え
    tmp <- pdf_pages
    pdf_pages <- pdf_spl
    pdf_spl <- tmp
  }
  pdf_paged <- purrr::map2_chr(
    pdf_pages, pdf_spl, qpdf::pdf_overlay_stamp) # ページ番号の重ね合わせ
  pdf_com <- pdftools::pdf_combine(pdf_paged) # PDFの結合
  fs::file_delete(c(pdf_pages, pdf_paged)) # 不要なPDFの削除
  return(pdf_com)
}
