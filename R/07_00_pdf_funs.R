  # 複数のPDFファイルからファイルを選択して分割する関数
  # 07_07_pdf-subset-fun.R
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
  # 07_08_pdf-user-input.R
  # 文字列を数値として返す関数
user_input <- function(prompt = "", choices = ""){
  prompt <- stringr::str_c(prompt, choices)
  if(interactive()){          # 双方向式のとき
    input <- readline(prompt) # 入力受付
    return(input)
  } else {                    # 双方向でないとき(スクリプトなど)
    cat(prompt)
    input <- readLines("stdin", n = 1) # 入力受付
    return(input)
  }
}

  # 文字列を数値として返す関数
eval_strings <- function(x){
  x |>
    stringr::str_replace_all("-", ":") |> # 「-」を「:」に変換
    stringr::str_split_1(",") |> # 「,」で分割
    str2expression() |>          # 文字列を式に
    as.list() |>                 # mapを使うためリストに
    purrr::map(eval) |>          # 評価
    unlist()                     # ベクトルに
}

  # ユーザ入力のページ数を数値に変換する関数
input_numbers <- function(prompt, choices = ""){
  inputs <- user_input(prompt, choices)
  pages <- eval_strings(inputs)
  return(pages)
}

  # ファイルの一覧を選択肢として返す関数
gen_choices <- function(files){
  no <- seq(files)
  stringr::str_c("  ", no, ": ", files, "\n", collapse = "")
}
  # ディレクトリ内のPDFのうち指定したものを結合する関数
  # 07_11_pdf-combine-fun.R
combine_pdf <- function(){
  files <- fs::dir_ls(regexp = "\\.pdf$")
  choices <- gen_choices(files)
  prompt <- "結合するファイル番号を指定してください．\n例：2,5,1\n"
  file_no <- input_numbers(prompt, choices)
  files <- files[file_no]
  pdf_combine(files)
}
  # PDFに含まれる画像を抽出する関数
  # 07_15_pdf-extract-images-fun.R
extract_images <- function(pdf, out = fs::path_temp(), bin_dir = ""){
  f_name <- 
    fs::path_file(pdf) |>                          # ファイル名のみ
    fs::path_ext_remove()                          # 拡張子の除去
  out_dir <- fs::path(out, f_name)                 # 出力ディレクトリ
  fs::dir_create(out_dir)
  out_file <- fs::path(out_dir, f_name)            # 出力ファイル
  bin <- "pdfimages"
  if(bin_dir != "") bin <- fs::path(bin_dir, bin)  # Popplerのディレクトリ
  cmd <- paste0(bin, " -all ", pdf, " ", out_file) # 実行コマンド
  paste0("Runnning ", cmd) |>                      # 実行中の表示
    message()
  system(cmd, intern = TRUE) |>                    # コマンド実行
    iconv("sjis", "utf8") |>                       # 文字化け対策
    message()
  return(out_dir)
}
  # ページ番号だけのページを作成する関数
  # 07_17_pdf-plot-page-number.R
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
  # 07_18_pdf-gen-page-numbers-fun.R
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
  # 07_20_pdf-add-page-numbers-fun.R
add_page_numbers <- function(path, y_pos = 5, size = 5, 
                             colour = "black", backside = FALSE, ...){
  pdf_spl <- pdftools::pdf_split(path) # 分割
  n <- length(pdf_spl)                 # PDFのページ数
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
  pdf_com <- pdftools::pdf_combine(pdf_paged)    # PDFの結合
  fs::file_delete(c(pdf_pages, pdf_paged))       # 不要なPDFの削除
  return(pdf_com)
}
  # 各種ファイルからPDFに変換する関数
  # 07_27_pdf-convert-fun.R
convert_app <- function(path, format){
  base_ext <- fs::path_ext(path)
  if (base_ext == format){  # 拡張子が入力と同じとき
    return(invisible(path)) # 終了
  }
  format_no <- set_format_no(base_ext, format)
  path <- normalizePath(path)        # Windowsの形式("\\")に変換："/"はエラー
  converted <-                       # 変換後の拡張子
    fs::path_ext_set(path, ext = format) |>
    normalizePath(mustWork = FALSE)
  officeApp <- 
    switch(base_ext,
           xlsx = "Excel.Application",
           pptx = "PowerPoint.Application",
           "Word.Application") |>
     RDCOMClient::COMCreate()
  officeApp[["Visible"]] <- TRUE        # アプリ表示
  officeApp[["DisplayAlerts"]] <- FALSE # 警告の非表示
  base_file <- switch(base_ext,
                xlsx = officeApp$workbooks()$Open(path),
                pptx = officeApp[["Presentations"]]$Open(path),
                officeApp[["Documents"]]$Open(path, ConfirmConversions = FALSE))
  base_file$SaveAs(converted, FileFormat = format_no)
  base_file$close()
  paste0("taskkill /f /im ",       # 終了コマンド
         switch(base_ext,
                xlsx = "excel",
                pptx = "powerpnt",
                "winword"),
         ".exe") |>
    system()                        # 実行
  return(fs::path(converted))
}

set_format_no <- function(base_ext, format){
  format_no <- 
    switch(base_ext,
      xlsx = switch(format,
                   pdf = 57),
      pptx = switch(format,
                    ppt = 1, rtf = 5, pptx = 11, ppsx = 28, pdf = 32,
                    wmf = 15, gif = 16, jpg = 17, png = 18, bmp = 19,
                    tif = 21, emf = 23,
                    wmv = 37, mp4 = 39),
      switch(format,
                    docx = 16, pdf = 17,
                    xps = 19, html = 20, rtf = 23, txt = 25))
}
