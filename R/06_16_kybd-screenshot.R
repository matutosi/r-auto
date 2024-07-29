  # スクリーンショット撮影
  # 06_16_kybd-screenshot.R
sc <- screenshot::screenshot()
 ## C:/Users/USERNAME/AppData/Local/Temp/RtmpkP1iLf/sc_287c4b4873da.png
imager::load.image(sc) |> plot() # imagerで読み込んで図示

