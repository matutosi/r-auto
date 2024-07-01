  # スクリーンショットの保存
  # 11_53_image-screenshot-screenshot.R
ss <- screenshot::screenshot()
fs::path_file(ss) # ファイル名のみ
 ## [1] "sc_158839211323.png"
magick::image_read(ss)
  # shell.exec(ss) # 関連付けアプリで起動

