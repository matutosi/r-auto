  # Title and Contentのレイアウトでのタイトルと画像の挿入
  # 10_15_powerpoint-add-fig.R
  # pp <- read_pptx()
wide <- "d:/matu/work/todo/r-auto/data/image_03_wide.jpg"
long <- "d:/matu/work/todo/r-auto/data/r_07.png"

df <- 
  tibble::tribble(
    ~title             , ~path, ~conter_horiz , ~conter_vert , ~fig_full,
    "横長(全体)"       , wide , FALSE         ,  FALSE       , TRUE     ,
    "横長(全体，中央)" , wide , TRUE          ,  TRUE        , TRUE     ,
    "横長(余白)"       , wide , FALSE         ,  FALSE       , FALSE    ,
    "横長(余白，中央)" , wide , TRUE          ,  TRUE        , FALSE    ,
    "縦長(全体)"       , long , FALSE         ,  FALSE       , TRUE     ,
    "縦長(全体，中央)" , long , TRUE          ,  TRUE        , TRUE     ,
    "縦長(余白)"       , long , FALSE         ,  FALSE       , FALSE    ,
    "縦長(余白，中央)" , long , TRUE          ,  TRUE        , FALSE    
  )
  # purrr::reduce()をデータフレームに適用する糖衣関数
preduce <- function(.l, .f, ..., .init, .dir = c("forward", "backward")){
  .dir <- match.arg(.dir)
  purrr::reduce(
    purrr::transpose(.l), 
    \(x, y){ rlang::exec(.f, x, !!!y, ...) }, 
    .init = .init, .dir = .dir)
}

pp <- preduce(df, add_fig, .init = pp)

print(pp, target = path)
  # shell.exec(path)

