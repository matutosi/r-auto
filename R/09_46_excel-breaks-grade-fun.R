  # 改ページのための区切りを取得する関数
  # 09_46_excel-breaks-grade-fun.R
breaks <- function(wb, sheet, col_name){
  res <- 
    new_categ_rows(wb, sheet, col_name, 
                   include_end = TRUE)[-1] |> # [-1]：タイトル行の区切りを削除
    magrittr::subtract(1) # subtract(1)は-1と同じ：区切りの上で改ページするため
}

