  # fuzzを指定した背景の塗りつぶし
  # 11_24_image-ffill-fuzz.R
image_fill(imgs[27], "white", fuzz = 20) |> 
  plot()

