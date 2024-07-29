  # 比率を指定して画像サイズを変更する関数
  # 11_23_image-scale-ratio-fun.R
image_scale_ratio <- function(image, ratio){
  round(magick::image_info(image)$width * ratio) |>
    purrr::map(magick::image_scale, image = image) |>
    magick::image_join()
}

