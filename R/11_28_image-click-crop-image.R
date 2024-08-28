  # 指定範囲の連続切り取り
  # 11_28_image-click-crop-image.R
files[1:3] |> # map版
  purrr::map(click_crop_image)
for(path in files[1:3]){ # for版
  click_crop_image(path)
}

