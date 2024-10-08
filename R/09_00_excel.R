  # openxlsxとreadxlのインストールと呼び出し
  # 09_01_excel-install.R
install.packages("openxlsx")
install.packages("readxl")
library(readxl)
library(openxlsx)

  # csvなどの読み込み
  # 09_02_excel-readr-read.R
file_csv <- readr::readr_example("mtcars.csv")
readr::read_csv(file_csv, show_col_types = FALSE) # csv(カンマ区切り)
  # readr::read_tsv(ファイル名)                   # tsv(タブ区切り)
  # readr::read_delim(ファイル名, delim = ",")    # delim：区切り文字

  # read_excel()によるデータフレームとしての読み込み
  # 09_03_excel-readxl-read.R
path <- readxl::readxl_example("datasets.xlsx")
iris <- readxl::read_excel(path, sheet = "iris") # シート名
iris |> head(3)
mtcars <- readxl::read_excel(path, sheet = 2)    # 番号

  # readWorkbook()によるデータフレームとしての読み込み
  # 09_04_excel-read.R
readWorkbook(path) |> head(3) # データフレームとしての読み込み

  # ワークブックとしての読み込み
  # 09_05_excel-load-wb.R
wb <- loadWorkbook(path) # ワークブックとしての読み込み
wb

  # excel.linkパッケージのインストールと呼び出し
  # 09_06_excel-ecxel.R
install.packages("excel.link")
library(readxl)

  # パスワード付きのエクセルファイルを開く疑似コード
  # 09_07_excel-read-with-password.R
library(RDCOMClient) # ないとエラーになる
excel.link::xl.read.file("ファイル名.xlsx",  password = "パスワード")

  # エクセルの全シートを読み込む関数の読み込み
  # 09_08_excel-read-all-sheets-source.R
source("https://matutosi.github.io/r-auto/R/02_00_analysis_funs.R")

  # Googleドライブからのファイルのダウンロード(疑似コード)
  # 09_09_excel-read-googledrive.R
install.packages("googledrive")
library(googledrive)
googledrive::drive_auth("YOURNAME@gmail.com") # 認証画面でパスワードなどを入力
sheet <- googledrive::drive_find(pattern = "検索文字列", type = "spreadsheet")
path <- "DIRECORY/FILE_NAME.csv"
googledrive::drive_download(
  sheet$name, path = path, type = "csv", overwrite = TRUE) # 上書きするとき

  # OneDriveからのファイルのダウンロード(疑似コード)
  # 09_10_excel-read-onedrive.R
install.packages("Microsoft365R")
library(Microsoft365R)
odb <- Microsoft365R::get_business_onedrive(tenant = "YOUR_COMPANY.OR.JP") # 認証
odb$list_files()
src <- "FILE_NAME"
dest <- "DIRECORY/FILE_NAME" # 認証画面でパスワードなどを入力
odb$download_file(src = src, dest = dest, overwrite = TRUE) # 上書きするとき

  # csvなどの書き込み
  # 09_11_excel-write-txt.R
readr::write_csv(mtcars, "fs::path_temp(mtcars.csv"))      # csv(カンマ区切り)
readr::write_tsv(mtcars, "fs::path_temp(mtcars.tsv"))      # tsv(タブ区切り)
readr::write_delim(iris, "fs::path_temp(iris.txt"), delim = ";") # ;区切り
ls("package:readr") |>         # ほかにもいろいろとある
  stringr::str_subset("write") # 詳細はヘルプ参照

  # データフレームのエクセル形式での書き込み
  # 09_12_excel-write-df.R
file_wb <- fs::path_temp("workbook.xlsx")
write.xlsx(iris, file_wb)

  # 分割したデータフレームのエクセルのシートごとへの書き込み
  # 09_13_excel-write-df-split.R
iris |>
  split(iris$Species) |>
  write.xlsx(file_wb)

  # ワークブックの書き込み
  # 09_14_excel-write.R
saveWorkbook(wb, file_wb, overwrite = TRUE)

  # パッケージのインストールと呼び出し
  # 09_15_excel-pivot-packages.R
install.packages("pivottabler")
install.packages("pivotea")
library(pivottabler)
library(pivotea)

  # ピボットテーブルの作成
  # 09_16_excel-pivot-qpvt.R
diamonds
pt_diamonds <- 
  pivottabler::qpvt(diamonds,
  rows = c("=", "color"),  # "="：結果(price、n)の表示場所・順序の指定に使う
  columns = "cut", 
  calculations = c("price" = "mean(price) |> round()", "n" = "n()"))
pt_diamonds

  # ピボットテーブルの書き込み
  # 09_17_excel-pivot-save.R
df_diamonds <- 
  pt_diamonds$asDataFrame() |>
  tibble::rownames_to_column("color") |>     # 行名を列に
  tidyr::separate_wider_delim(color,         # 結果と色を別の列に
    delim = " ", names = c("calc", "color"))
file_diamonds <- fs::path_temp("df_diamonds.tsv")
readr::write_tsv(df_diamonds, file_diamonds)
  # shell.exec(file_diamonds) # 関連付けアプリで開く

  # ピボットテーブルの表示
  # 09_18_excel-pivot-show.R
pt_diamonds$renderPivot() # ビューア(RStudio)やブラウザ(R)で表示

  # 文字列の入った表の作成
  # 09_19_excel-pivot-pivotea.R
url <- "https://matutosi.github.io/r-auto/data/timetable.csv"
csv <- fs::path_temp("timetable.csv")
curl::curl_download(url, csv) # urlからダウンロード
syllabus <- 
  readr::read_csv(csv, show_col_types = FALSE) |>
  dplyr::mutate(subj = paste0(stringr::str_sub(subject, 1, 2),
                              stringr::str_sub(subject, -2, -1))) |>
  dplyr::mutate(wday = stringr::str_replace(wday, "月", "1月")) |>
  dplyr::mutate(wday = stringr::str_replace(wday, "火", "2火")) |>
  dplyr::mutate(wday = stringr::str_replace(wday, "水", "3水")) |>
  dplyr::mutate(wday = stringr::str_replace(wday, "木", "4木")) |>
  dplyr::mutate(wday = stringr::str_replace(wday, "金", "5金"))
timetable <- 
  syllabus |>
  pivotea::pivot(row = c("grade", "hour"), col = "wday", 
  val = c("subj", "teacher"), split = "semester")
head(timetable[[1]])
file_timetable <- fs::path_temp("timetable.xlsx")
write.xlsx(timetable, file_timetable) # シート別に書き込み
  # shell.exec(file_timetable)

  # 列幅の設定
  # 09_20_excel-width-sheet1.R
wb <- loadWorkbook(file_timetable) # ワークブック読み込み
setColWidths(wb, 1, cols = 1:10, width = "auto")  # 列幅の変更
saveWorkbook(wb, file_timetable, overwrite = TRUE)  # ワークブックの書き込み

  # 列幅を変更する関数
  # 09_21_excel-width-fun.R
set_col_width_auto <- function(wb_path){ # wb_path：ワークブックのパス(文字列)
  wb <- openxlsx::loadWorkbook(wb_path) # 読込
  for(sheet in sheets(wb)){             # シートごと
    cols <-                             # 列番号
      openxlsx::readWorkbook(wb, sheet) |>
      ncol() |> 
      seq() # seq(5)で1:5と同じ
    openxlsx::setColWidths(wb, sheet, cols, width = "auto") # 列幅の設定
  }
  openxlsx::saveWorkbook(wb, wb_path, overwrite = TRUE) # 書き込み
}

  # 列幅の変更
  # 09_22_excel-width-all.R
set_col_width_auto(file_timetable) # 関数実行

  # オートフィルタの設定
  # 09_23_excel-autofilter.R
wb <- loadWorkbook(file_timetable)
addFilter(wb, sheet = 1, rows = 1, cols = 1:10)
saveWorkbook(wb, file_timetable, overwrite = TRUE)  # ワークブックの書き込み

  # 全シートに同じ関数を実行する関数
  # 09_24_excel-autofilter-map-fun.R
walk_wb <- function(wb, fun, ...){
  openxlsx::sheets(wb) |>       # シート名を取得
    purrr::walk(fun, wb = wb, ...) # fun(wb = wb, sheet = sheet)のように受け取る
}

  # コードを簡潔にするための糖衣関数
  # 09_25_excel-autofilter-wrapper-fun.R
  # addFilter()の糖衣関数
add_filter <- function(wb, sheet, rows = 1){
  cols <- cols_wb_sheet(wb, sheet)
  openxlsx::addFilter(wb, sheet, rows = rows, cols = cols)
}
  # setColWidths()の糖衣関数
set_col_width <- function(wb, sheet, width = "auto", ...){
  cols <- cols_wb_sheet(wb, sheet)
  openxlsx::setColWidths(wb, sheet, cols = cols, width = width, ...)
}
  # wbとsheetでの列数を取得
cols_wb_sheet <- function(wb, sheet){
  openxlsx::readWorkbook(wb, sheet) |> 
    ncol() |> seq()
}

  # 全シートでのオートフィルタと列幅の設定
  # 09_26_excel-autofilter-fun.R
wb <- loadWorkbook(file_timetable)
walk_wb(wb, add_filter)
walk_wb(wb, set_col_width)
saveWorkbook(wb, file_timetable, overwrite = TRUE)

  # 個別のシートでのウィンドウ枠の固定
  # 09_27_excel-freezepanel.R
freezePane(wb, 1, firstRow = TRUE, firstCol = TRUE) # 1行目と1列目を固定

  # ウィンドウ枠を固定する関数
  # 09_28_excel-freezepanel-fun.R
  # freezePane()の糖衣関数
freeze_pane <- function(wb, sheet){
  openxlsx::freezePane(wb, sheet, firstRow = TRUE, firstCol = TRUE)
}

  # すべてのシートでのウィンドウ枠の固定
  # 09_29_excel-freezepanel-all.R
wb <- loadWorkbook(file_timetable)
walk_wb(wb, freeze_pane)
saveWorkbook(wb, file_timetable, overwrite = TRUE)

  # 設定可能な罫線の一覧作成
  # 09_30_excel-border-style.R
border <- "bottom"
style <- 
  c("thin", "medium", "dashed", "dotted", "thick", "double", 
    "hair", "mediumDashed", "dashDot", "mediumDashDot", 
    "dashDotDot", "mediumDashDotDot", "slantDashDot")
styles <- 
  style |>
  purrr::map(\(x){ createStyle(border = border, borderStyle = x) })
wb <- createWorkbook()          # ワークブックを作成
addWorksheet(wb, 1, zoom = 200) # シートを追加
writeData(wb, sheet = 1, style) # データ書き込み
file_border <- fs::path_temp("border.xlsx")
styles |>
  purrr::iwalk(\(.x, .y){
    addStyle(wb, 1,            # 罫線のスタイルを適用
    style = .x,                # .x：style[[i]]、iは1からnまで
    rows = .y, cols = 1)}      # .y：i
  )
saveWorkbook(wb, file_border, overwrite = TRUE) # 書き込み
  # shell.exec(file_border)

  # 単純な罫線を引く関数
  # 09_31_excel-border-fun.R
set_border <- function(wb, sheet, 
                       border = "Bottom", borderStyle = "thin", 
                       style = NULL){
  if(is.null(style)){
    style <- createStyle(border = border, borderStyle = borderStyle)
  }
  rows <- rows_wb_sheet(wb, sheet) # シートごとの行数
  cols <- cols_wb_sheet(wb, sheet) # シートごとの列数
  addStyle(wb, sheet, style = style, rows = rows, cols = cols, 
    gridExpand = TRUE,  # rowsとcolsの組み合わせで範囲を拡張
    stack = TRUE)       # 既存の書式に追加
}

  # シートごとの行数を取得する関数
  # 09_32_excel-rows-wb-sheet-fun.R
rows_wb_sheet <- function(wb, sheet){
  rows <- 
    openxlsx::readWorkbook(wb, sheet) |> 
    nrow() |> magrittr::add(1) |> seq() # +1：列名の1行を追加
}

  # データの範囲に罫線を引く
  # 09_33_excel-border-all.R
walk_wb(wb, set_border, border = c("bottom", "right"))
walk_wb(wb, set_col_width)
saveWorkbook(wb, file_border, overwrite = TRUE)

  # セルの内容の区別で罫線を引く関数
  # 09_34_excel-border-condition-fun.R
  # 区別として罫線を引く位置
new_categ_rows <- function(wb, sheet, col_name, include_end = FALSE){
  df <- openxlsx::readWorkbook(wb, sheet)
  old_categ <- df[[col_name]] != dplyr::lag(df[[col_name]]) # lag：1つずらす
  old_categ <- c(1, which(old_categ)) # 1: タイトル行
  if(include_end){ # 最後のカテゴリの終わりを含める
    old_categ <- c(old_categ, nrow(df) + 1) # nrow(df)+1：最終行の次
  }
  new_categ <- old_categ + 1 # タイトルの分として+1する
  return(new_categ)
}
  # 学年別で太線を引く
border_between_categ <- function(wb, sheet, categ){
  style <- createStyle(border = "top", borderStyle = "thick") # 書式
  rows <- new_categ_rows(wb, sheet, categ)                    # 範囲
  set_border(wb, sheet, rows = rows, style = style)           # 設定
}
  # set_border()の拡張版
set_border <- function(wb, sheet, rows = NULL, cols = NULL, 
                       border, borderStyle, style = NULL, 
                       gridExpand = TRUE){
    if(is.null(style)){
        style <- createStyle(border = border, borderStyle = borderStyle)
    }
    if(is.null(rows)){ rows <- rows_wb_sheet(wb, sheet) }
    if(is.null(cols)){ cols <- cols_wb_sheet(wb, sheet) }
    addStyle(wb, sheet, style = style, rows = rows, cols = cols, 
             gridExpand = TRUE,  # rowsとcolsの組み合わせで範囲を拡張
             stack = TRUE)       # 既存の書式に追加
}

  # 学年の区別で太線を引く
  # 09_35_excel-border-condition-grade.R
wb <- loadWorkbook(file_timetable)
walk_wb(wb, border_between_categ, categ = "grade")
saveWorkbook(wb, file_timetable, overwrite = TRUE)

  # 文字列に合致する列番号を取得する関数
  # 09_36_excel-content-cols-fun.R
content_cols <- function(wb, sheet, str){
  df <- openxlsx::readWorkbook(wb, sheet)
  which(colnames(df) == str)
}

  # セルの文字列に合わせて罫線を引く関数
  # 09_37_excel-border-condition-hour-fun.R
border_between_contents <- function(wb, sheet, border = "right", 
                                    borderStyle = "double", str){
  style <- createStyle(border = border, borderStyle = borderStyle) # 書式
  cols <- content_cols(wb, sheet, str = str)                       # 範囲
  set_border(wb, sheet, cols = cols, style = style)                # 設定
}

  # hour列の右に二重線を引く
  # 09_38_excel-border-condition-hour.R
wb <- loadWorkbook(file_timetable)
walk_wb(wb, border_between_contents, str = "hour")
saveWorkbook(wb, file_timetable, overwrite = TRUE)

  # データの外枠に罫線を引く関数
  # 09_39_excel-border-condition-frame-fun.R
border_frame <- function(wb, sheet, borderStyle = "mediumDashDot"){
  # 書式
  style_t <- createStyle(border = "top",    borderStyle = borderStyle)
  style_b <- createStyle(border = "bottom", borderStyle = borderStyle)
  style_l <- createStyle(border = "left",   borderStyle = borderStyle)
  style_r <- createStyle(border = "right",  borderStyle = borderStyle)
  # 範囲
  rows <- rows_wb_sheet(wb, sheet)
  cols <- cols_wb_sheet(wb, sheet)
  rows_t <- 1
  rows_b <- max(rows)
  cols_l <- 1
  cols_r <- max(cols)
  # 書式の適用
  set_border(wb, sheet, rows = rows_t, cols = cols  , style = style_t) # 上
  set_border(wb, sheet, rows = rows_b, cols = cols  , style = style_b) # 下
  set_border(wb, sheet, rows = rows  , cols = cols_l, style = style_l) # 左
  set_border(wb, sheet, rows = rows  , cols = cols_r, style = style_r) # 右
}

  # データの外枠に1点鎖線を引く
  # 09_40_excel-border-condition-frame.R
wb <- loadWorkbook(file_timetable)
walk_wb(wb, border_frame)
saveWorkbook(wb, file_timetable, overwrite = TRUE)

  # 条件付き書式設定による背景色を変更する関数
  # 09_41_excel-bg-color-fun.R
set_bg_color <- function(wb, sheet, color = "#FFFF00", strings){
  bg_color <- openxlsx::createStyle(bgFill = color)
  for(str in strings){ # stringの数だけ繰り返し
    openxlsx::conditionalFormatting(wb, sheet, 
      rows = rows_wb_sheet(wb, sheet), 
      cols = cols_wb_sheet(wb, sheet), 
      rule = str, style = bg_color, type = "contains")
  }
}

  # 条件付き書式設定による背景色の変更
  # 09_42_excel-bg-color.R
walk_wb(wb, set_bg_color, color = "yellow", strings = c("衣", "食", "住"))
saveWorkbook(wb, file_timetable, overwrite = TRUE)
  # shell.exec(file_timetable)

  # いろいろな条件付き書式設定の例
  # 09_43_excel-conditionals.R
val <- 1:10
str <- stringr::fruit[val]
df <- tibble::tibble(
  equal_3 = val, colourScale = val, databar = val, top5 = val, bottom3 = val, 
  duplicates = letters[sample(1:9, 10, replace = TRUE)],
  beginsWith_a = str, endsWith_e = str, contains_p = str, notContains_c = str)
file_cond <- fs::path_temp("conditional.xlsx")
write.xlsx(df, file_cond)
wb_cond <- loadWorkbook(file_cond)
rows <- 2:11
conditionalFormatting(wb_cond, 1, cols = 1, rows = rows,
  type = "expression", rule = "==3")                # 3と同じ
conditionalFormatting(wb_cond, 1, cols = 2, rows = rows,
  type = "colourScale", style = c("blue", "white"), # カラースケール
  rule = c(0, 10))
conditionalFormatting(wb_cond, 1, cols = 3, rows = rows,
  type = "databar", style = c("yellow"))            # データバー
conditionalFormatting(wb_cond, 1, cols = 4, rows = rows,
  type = "topN", rank = 5)                          # 上位5つ
conditionalFormatting(wb_cond, 1, cols = 5, rows = rows,
  type = "bottomN", rank = 3)                       # 下位3つ
conditionalFormatting(wb_cond, 1, cols = 6, rows = rows,
  type = "duplicates")                              # 重複
conditionalFormatting(wb_cond, 1, cols = 7, rows = rows,
  type = "beginsWith",  rule = "a")                 # aで始まる
conditionalFormatting(wb_cond, 1, cols = 8, rows = rows,
  type = "endsWith",    rule = "e")                 # eで終わる
conditionalFormatting(wb_cond, 1, cols = 9, rows = rows,
  type = "contains",    rule = "p")                 # pを含む
conditionalFormatting(wb_cond, 1, cols = 10, rows = rows,
  type = "notContains", rule = "c")                 # cを含まない
saveWorkbook(wb_cond, file_cond, overwrite = TRUE)

