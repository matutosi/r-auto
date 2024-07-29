  # 画像をクリックして位置を取得する関数
  # 11_30_image-click-locate-image-fun.R
click_locate_image <- function(img, n = 2){
  par(mar = rep(0.1, 4))        # 余白を狭く
  par(oma = rep(0.1, 4))
  plot(img)                     # 描画
  pos <- locator(n = n)         # 位置取得の回数
  pos <- purrr::map(pos, round) # 丸め
  w <- magick::image_info(img)$width
  h <- magick::image_info(img)$height
  pos$y <- h - pos$y            # 上下位置の反転
  pos <- 
    seq(n) |>
    purrr::map(\(i){ c(pos$x[i], pos$y[i]) } )
  return(pos)
}

