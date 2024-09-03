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

