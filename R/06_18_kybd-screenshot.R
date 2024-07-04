  # スクリーンショット撮影
  # 06_18_kybd-screenshot.R
sc <- screenshot::screenshot()
 ## C:/Users/USERNAME/AppData/Local/Temp/RtmpkP1iLf/sc_287c4b4873da.png
imager::load.image(sc) # imagerで読み込み
  |> plot()            # 表示
  # shell.exec(sc) # 関連付けアプリで開く場合

