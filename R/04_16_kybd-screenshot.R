  # スクリーンショット撮影
  # 04_16_kybd-screenshot.R
sc <- screenshot::screenshot()
magick::image_read(sc) |> plot() # 読み込んで図示

