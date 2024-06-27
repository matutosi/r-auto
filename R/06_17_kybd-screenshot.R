  # スクリーンショット撮影
  # 06_17_kybd-screenshot.R
ss <- screenshot::screenshot()
 ## C:/Users/USERNAME/AppData/Local/Temp/RtmpkP1iLf/sc_287c4b4873da.png
imager::load.image(ss) |> plot() # imagerで読み込み・表示
  # shell.exec(ss) # 関連付けアプリで開く場合

