  # Title and Contentのレイアウトでのタイトルと画像の挿入
  # 10_15_powerpoint-add-fig.R
  # pp <- read_pptx()
imgs <- c("image_03_wide.jpg", "r_07.png")
urls <- paste0("https://matutosi.github.io/r-auto/data/", imgs)
path_imgs <- fs::path_temp(imgs)
curl::multi_download(urls, path_imgs) # urlからPDFをダウンロード
wide <- path_imgs[1]
long <- path_imgs[2]
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

