  # 複数画像を拡張子の形式で書き込む関数
  # 11_13_image-write-images-fun.R
images_write <- function(images, paths){
  formats <- fs::path_ext(paths) # 拡張子の形式
  tibble::tibble(image = as.list(images), path = paths, format = formats) |>
      purrr::pwalk(magick::image_write)
}

