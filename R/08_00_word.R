  # officerとRDCOMClientのインストールと呼び出し
  # 08_01_word-install.R
install.packages("officer")
library("officer")

  # 作業用ファイルのダウンロード
  # 08_02_word-download.R
  # install.packages("curl")
url <- "https://matutosi.github.io/r-auto/data/doc_1.docx"
path_doc_1 <- 
  fs::path_file(url) |>
  fs::path_temp()
curl::curl_download(url, path_doc_1) # urlからダウンロード
  # shell.exec(path_doc_1)

  # ワードファイルの読み込み
  # 08_03_word-read-docx.R
doc_1 <- read_docx(path_doc_1)
doc_1

  # 文書の書き出し
  # 08_04_word-print.R
path_doc_2 <- fs::path_temp("doc_2.docx")
print(x = doc_1, target = path_doc_2)
  # shell.exec(path_doc_2)

  # 概要の表示
  # 08_05_word-docx-summary.R
doc_1 |>
  docx_summary() |>
  tibble::as_tibble() |>
  head()

  # 見出しを含む本文の取り出し
  # 08_06_word-docx-summary-filter-paragraph.R
doc_1 |>
  docx_summary() |>
  tibble::as_tibble() |>
  dplyr::filter(content_type == "paragraph") |>
  dplyr::select(content_type, style_name, text) |>
  dplyr::filter(text != "") |>
  print(n = 5)

  # 見出しを除く本文の取り出し
  # 08_07_word-docx-summary-filter-normal.R
doc_1 |>
  docx_summary() |>
  tibble::as_tibble() |>
  dplyr::filter(style_name == "Normal") |>
  dplyr::select(content_type, style_name, text) |>
  dplyr::filter(text != "") |>
  print(n = 5)

  # ワードから文字列を抽出する関数
  # 08_08_word-docx-extract-text-fun.R
extract_docx_text <- function(docx, normal = TRUE, heading = TRUE, flatten = TRUE){
  if(sum(normal, heading) == 0){ # 両方ともFALSEのとき
    return("") # ""を返す
  }
  condtion <-  # 検索条件："normal|heading", "normal", "heading" のうち1つ
    c("Normal"[normal], "heading"[heading]) |>
    paste0(collapse = "|")
  text <-      # 文字列
    docx |>
    officer::docx_summary() |>
    dplyr::filter(stringr::str_detect(style_name, condtion)) |>
    dplyr::filter(text != "") |>
    dplyr::select(text)
  if(flatten) text <- text$text
  return(text)
}

  # ワードから文字列の抽出
  # 08_09_word-docx-extract-text.R
extract_docx_text(doc_1, heading = FALSE)
extract_docx_text(doc_1, normal = FALSE, flatten = FALSE)

  # ワードの内容をテキストとして保存
  # 08_10_word-save-text.R
path_txt <- fs::path_temp("doc.txt")
doc_1 |>
  extract_docx_text(flatten = FALSE) |>
  readr::write_tsv(path_txt, col_names = FALSE)
  # shell.exec(path_txt)

  # 正規表現による置換
  # 08_11_word-replace-regexp-1.R
doc_1 |> # 置換前
  extract_docx_text(heading = FALSE) |>
  `[`(_, 1:5)
doc_1 <- # 正規表現による置換
  body_replace_all_text(doc_1, "オラウ.タン", "オランウータン")
doc_1 |> # 置換後
  extract_docx_text(heading = FALSE) |>
  `[`(_, 1:5)

  # 正規表現による置換(マッチ部分の参照)
  # 08_12_word-replace-regexp-2.R
str <- c(paste0("第", 1:3, "回"), "次第", "回転")
str
stringr::str_replace_all(str, "第(\\d)回", "\\1回目")

  # フォントサイズとフォントタイプを変更
  # 08_13_word-set-font.R
doc_1 <- 
  doc_1 |>
  docx_set_paragraph_style(style_id = "Normal", style_name = "Normal",
    fp_t = fp_text(font.size = 18, font = "Yu Gothic")) |>
  docx_set_paragraph_style(style_id = "Titre1", style_name = "heading 1",
    fp_t = fp_text(font.size = 40, font = "MS Gothic")) |>
  docx_set_paragraph_style(style_id = "Titre2", style_name = "heading 2",
    fp_t = fp_text(font.size = 30, font = "MS Mincho")) |>
  docx_set_paragraph_style(style_id = "Titre3", style_name = "heading 3",
    fp_t = fp_text(font.size = 20, font = "UD デジタル 教科書体 NK-R"))
print(x = doc_1, target = path_doc_1)

  # ページ設定
  # 08_14_word-page.R
size <- page_size(orient = "landscape") # 横向き
mar <- 0.4                              # 1インチ：約1cm
margins <- page_mar(mar, mar, mar, mar, # 順に下上右左の余白
                    mar/2, mar/2,       # ヘッダーとフッターの位置
                    0)                  # 綴じ代
ps <- prop_section(page_size = size, page_margins = margins)
doc_1 <- body_set_default_section(doc_1, value = ps)
print(x = doc_1, target = path_doc_1)

  # コメントの抽出
  # 08_15_word-docx-comment.R
comment <- 
  docx_comments(doc_1) |>
  tibble::as_tibble() |>
  print()

  # 文字列を比較して異なるときのみ貼り付ける関数
  # 08_16_word-cumulative-paste-fun.R
cumulative_paste <- function(x, y){
  if(x == y){    # xとyが同じなら
    x            #   xのまま
  }else{         # xとyが異なれば
    paste0(x, y) #   xとyを貼り付け
  }
}

  # コメントの保存
  # 08_17_word-docx-comment-write.R
comment_path <- fs::path_temp("comment.xlsx")
comment |>
  tidyr::unnest_longer(-comment_id) |> 
  dplyr::summarise(
    .by = c(comment_id, author, initials, date),  # コメントでグループ化
    text = reduce(text, cumulative_paste),
    commented_text = reduce(commented_text, cumulative_paste)) |> 
  openxlsx::write.xlsx(comment_path)
wb <- openxlsx::loadWorkbook(comment_path)                 # 読み込み
openxlsx::setColWidths(wb, 1, cols = 1:7, width = "auto")  # 列幅の変更
openxlsx::saveWorkbook(wb, comment_path, overwrite = TRUE) # 保存
  # shell.exec(comment_path)

  # ディクトリ内のワードから画像を抽出する関数
  # 08_18_word-extract-docx-img-fun.R
extract_docx_imgs <- function(path) {
  docxs <- fs::dir_ls(path, regexp = "\\.docx$") # ワードの一覧
  zips <-
    docxs |>
    fs::path_file() |>         # ファイル名のみ
    fs::path_ext_set("zip") |> # 拡張子をzipに変更
    fs::path_temp()            # 一時ファイル
  fs::file_copy(docxs, zips, overwrite = TRUE) # docxをzipとして複製
  zip_dirs <- fs::path_ext_remove(zips)        # 拡張子の除去
  purrr::walk2(zips, zip_dirs, 
    \(x, y){ unzip(zipfile = x, exdir = y) })  # 解凍
  images <- purrr::map(zip_dirs, extract_imgs) # 画像の抽出
  images <- 
    unlist(images) |>
    fs::file_move(path) # 画像の移動
  return(images)
}

  # ディレクトリから画像を抽出する関数
  # 08_19_word-extract-img-fun.R
extract_imgs <- function(zip_dir) {
  img_dir <- fs::path(zip_dir, "word/media") # 画像ディレクトリ
  if(fs::dir_exists(img_dir)){               # ディレクトリの有無の確認
    img_files <- fs::dir_ls(img_dir)         # 画像ファイル
      # 変更後の画像ファイル
    img_files_new <- paste0(zip_dir, "_", fs::path_file(img_files))
      # 画像ファイルの複写
    fs::file_copy(img_files, img_files_new, overwrite = TRUE)
    return(img_files_new)
  }else{
    return(fs::path())
  }
}

  # ディクトリ内のワードから画像を抽出
  # 08_20_word-extract-docx-img.R
dir <- fs::dir_create(fs::path_temp(), "images") # ディレクトリの作成
fs::file_copy(c(path_doc_1, path_doc_2), dir)    # ファイルを複写
imgs <- extract_docx_imgs(dir)                   # ワードから画像を抽出
fs::path_file(imgs)                              # 抽出した画像のファイル名
 # shell.exec(dir)

  # 日付関連の関数の読み込み
  # 08_21_word-date-fun.R
source("https://matutosi.github.io/r-auto/R/06_00_date_funs.R")

  # ワードの文書内の日付の修正
  # 08_22_word-update-dates.R
text <- extract_docx_text(doc_1) # 文字列の抽出
dates_before <- # 日付の抽出
  extract_date_ish(text) |>
  unlist()
dates_after <- update_wday(dates_before)  # 正しい曜日
tibble::tibble(dates_before, dates_after) # 置換文字列の一覧
doc_1 <- 
  purrr::reduce2(.x = dates_before, .y = dates_after, 
                 .f = body_replace_all_text, .init = doc_1, fixed = TRUE)
print(doc_1, path_doc_1)
  # shell.exec(path_doc_1)
  # forループのとき
  # for(i in 1:length(dates_before)){
  #   docx_1 <- docx_1 |>
  #     body_replace_all_text(dates_before[i], dates_after[i], fixed = TRUE)
  # }

  # 日付の1年後の同じ位置への更新
  # 08_23_word-dates-next-yr.R
dates_next_yr <- 
  dates_before |>
  lubridate::ymd() |>
  same_pos_next_yr()
tibble::tibble(dates_before, dates_next_yr) # 置換文字列の一覧
doc_1 <- 
  purrr::reduce2(.x = dates_before, .y = dates_next_yr, 
                 .f = body_replace_all_text, .init = doc_1, fixed = TRUE)

  # 文字列や画像をまとめて入力する関数
  # 08_24_word-insert-fun.R
insert_texts <- function(docx, str, style = "Normal", ...){
  purrr::reduce(str, officer::body_add_par, 
                style = style, .init = docx, ...)
}
insert_images <- function(docx, images, width = 3, height = NULL, ...){
  size <- magick::image_read(images) |>
    magick::image_info() |> `[`(_, c("width", "height"))
  if(is.null(height)) height <- width * (size[[2]] / size[[1]])
  tibble(src = images, width = width, height = height) |>
    preduce(officer::body_add_img, .init = docx, ...)
}
  # insert_imagesの助関数
preduce <- function(.l, .f, ..., .init, .dir = c("forward", "backward")){
  .dir <- match.arg(.dir)
  reduce(.x = transpose(.l), 
         .f = \(x, y){ exec(.f, x, !!!y, ...) }, 
         .init = .init, 
         .dir = .dir)
}

  # 文字列をまとめて入力(疑似コード)
  # 08_25_word-insert-text.R
text <- c("文章1", "文章2", "文章3")
images <- c("a.jpg", "b.png")
new_doc <- read_docx() |>
  insert_texts(text) |>
  insert_images(images)
print(new_doc, fs::path_home("new.docx"))

