  # 指定範囲の連続切り取り
  # 11_46_click-crop-image.R
path_imgs <- fs::path_temp(files)
  # map
path_imgs[1:3] |>
  purrr::map(click_crop_image)
  # for
for(path in path_imgs[1:3]){
  click_crop_image(path)
}

