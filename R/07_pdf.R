  # pdftoolsとqpdfのインストール
  # 07_01_pdf-install.R
install.packages("pdftools")
install.packages("qpdf")

  # pdftoolsとqpdfの呼び出し
  # 07_02_pdf-library.R
library(pdftools)  # Popplerのバージョンが表示される
library(qpdf)

  # 作業用PDFのダウンロード
  # 07_03_pdf-download.R
  # install.packages("curl")
url <- "https://matutosi.github.io/r-auto/data/base.pdf"
pdf_base <- fs::path_temp("base.pdf")
curl::curl_download(url, pdf_base) # urlからPDFをダウンロード

  # PDFのページ数の取得
  # 07_04_pdf-length.R
pdf_length(pdf_base)

  # PDFの分割
  # 07_05_pdf-split.R
pdf_spl <- 
  pdf_split(pdf_base)
fs::path_file(pdf_spl) # ファイル名のみ

  # PDFのページ抽出
  # 07_06_pdf-subset.R
pdf_sub <- pdf_subset(pdf_base, pages = c(1,5))
fs::path_file(pdf_sub)

  # PDFのページ順序の入れ替え
  # 07_07_pdf-subset-reverse.R
len <- pdf_length(pdf_base)
pdf_reverse <- pdf_subset(pdf_base, pages = len:1) # 逆順
odd_pages <- seq(from = 1, to = len, by = 2)       # 奇数ページのみ
pdf_odd <- pdf_subset(pdf_base, pages = odd_pages)
odd_rev <- sort(odd_pages, decreasing = TRUE)      # 奇数ページの逆順
pdf_odd_rev <- pdf_subset(pdf_base, pages = odd_rev)

  # ページの重複エラー
  # 07_08_pdf-subset-dup.R
pdf_dup <- pdf_subset(pdf_base, pages = rep(1:3, 2)) # 重複はエラー

  # 複数のPDFファイルからファイルを選択して分割する関数
  # 07_09_pdf-subset-fun.R
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

  # subset_pdf()の実行例
  # 07_10_pdf-subset-exec.R
subset_pdf()
  #   $a_output.pdf
  # [1] "C:\\Users\\ユザー名\\a_output_output.pdf"

  # PDFの結合
  # 07_11_pdf-combine.R
pdf_spl |>                      # 分割したPDF
  purrr::map_int(pdf_length)    # 各PDFのページ数
pdf_com <- pdf_combine(pdf_spl) # 結合
fs::path_file(pdf_com)          # 結合したファイル名
pdf_length(pdf_com)             # 結合したPDFのページ数

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

  # PDFの回転
  # 07_13_pdf-rotate.R
pdf_rtt <- pdf_rotate_pages(pdf_com, pages = c(1,3))
fs::path_file(pdf_rtt) # ファイル名のみ

  # PDFの圧縮と最適化
  # 07_14_eval.R
pdf_compressed <- pdf_compress(pdf_base, linearize = TRUE)

  # PDFから文字列の抽出
  # 07_15_pdf-text.R
text <- 
  pdf_spl[1:3] |>     # 1-3ページ
  pdf_combine() |>    # 結合
  pdf_text() # 文字列の抽出
text |>
  stringr::str_split("\n") # 改行(\n)で分割

  # PDFを画像ファイルに変換
  # 07_16_pdf-convert.R
  # pdf_convert(pdf_base, pages = 1:2) # かなり時間がかかる
pdf_combine(pdf_spl[1:2]) |>
  pdf_convert(filenames = paste0("072_", 1:2, ".png")) # 既定値の72dpi
pngs <- 
  pdf_combine(pdf_spl[1:2]) |>
  pdf_convert(filenames = paste0("300_", 1:2, ".png"), dpi = 300)

  # tesseractのインストール
  # 07_17_pdf-tesseract-install.R
install.packages("tesseract")
tesseract::tesseract_download(lang = "jpn")

  # PDF内の画像の文字認識
  # 07_18_pdf-ocr.R
ocr_data <- 
  pdf_ocr_data(pdf_spl[1], language = "jpn") |>
  magrittr::extract2(1) # [[[1]]と同じ
head(ocr_data)
pdf_ocr_text(pdf_spl[1], language = "jpn") |>
  stringr::str_split("\n") |>
  magrittr::extract2(1) |> # [[[1]]と同じ
  head()

  # 精度の高い結果のみを抽出
  # 07_19_pdf-ocr-filter.R
word <- 
  ocr_data |>
  dplyr::filter(confidence > 75) |>
  `$`(_, "word") |> # $wordの取り出し
  paste0(collapse = "") # 文字列の結合

  # PDFに含まれる画像を抽出する関数
  # 07_20_pdf-extract-images-fun.R
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

  # PDFに含まれる画像の抽出
  # 07_21_pdf-extract-images.R
image_dir <- extract_images(pdf_base)
  # shell.exec(image_dir) # ディレクトリを表示

  # ページ番号だけのページを作成する関数
  # 07_22_pdf-plot-page-number.R
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
  # 07_23_pdf-gen-page-numbers-fun.R
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

  # ページ番号を大きく作成
  # 07_24_pdf-gen-page-numbers.R
pdf_pages <- gen_page_numbers(n = 10, size = 200, y_pos = 150)

  # ページ番号を重ね合わせる関数
  # 07_25_pdf-add-page-numbers-fun.R
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

  # ページ番号の重ね合わせ
  # 07_26_pdf-add-page-numbers.R
pdf_paged <- add_page_numbers(pdf_base, size = 200, y_pos = 150, colour = "yellow")

