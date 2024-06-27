  # 最大行数と改ページ位置を比較して改ページを設定する関数
  # 09_50_excel-page-compare-add-breaks-fun.R
#' Page breaks
#' Add page breaks for timetable
add_page_break <- function(wb, sheet, col_name, page_size = 30){
  breaks <- 
    new_categ_rows(wb, sheet, col_name, 
                   include_end = TRUE)[-1] |> # [-1]：タイトル行の区切りを削除
    magrittr::subtract(1)    # subtract(1)は-1と同じ：区切りの上で改ページ
  breaks <- compare_page_break(breaks, page_size)
  openxlsx::pageBreak(wb, sheet, breaks)
}

