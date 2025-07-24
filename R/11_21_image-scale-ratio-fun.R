  # 比率を指定して画像の大きさを変更する関数
  # 11_21_image-scale-ratio-fun.R
image_scale_ratio <- function(image, ratio){
  round(magick::image_info(image)$width * ratio) |>
    purrr::map(magick::image_scale, image = image) |>
    magick::image_join() # リストを結合してもとの画像オブジェクトに戻す
}

