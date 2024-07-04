  # 最大行数と改ページ位置を比較する関数
  # 09_51_excel-page-compare-breaks-fun.R
compare_page_break <- function(breaks, page_size = 30){
  page_size_next <- page_size                              # 最大行数の初期値
  page_breaks <- NULL                                      # 結果を返す変数
  while(length(breaks) > 1){                               # 改ページが複数
    is_under_page_brekas <- which(breaks < page_size_next) # 最大行数と比較
    if(length(is_under_page_brekas) == 0){                 # 最大行数以上
      message("Page breaks is OVER Page Size!")
      return(breaks)
    }
    index <- max(is_under_page_brekas)                     # 最大値の位置
    page_breaks <- c(page_breaks, breaks[index])           # 改ページの追加
    page_size_next <- breaks[index] + page_size            # 次の最大行数
    if(length(breaks) == index){                           # 改ページ終了
      return(page_breaks)
    }
    breaks <- breaks[(index + 1):length(breaks)]           # 残りの改ページ
  }
  is_under_page_brekas <- which(breaks < page_size_next)   # 最大行数と比較
  if(length(is_under_page_brekas) == 0){                   # 最大行数以上
    message("Page breaks is OVER Page Size!")
  }
  return(c(page_breaks, breaks))
}

