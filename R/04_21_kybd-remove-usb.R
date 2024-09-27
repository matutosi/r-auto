  # USBの取り出しコードの例
  # 04_21_kybd-remove-usb.R
pos_original <- KeyboardSimulator::mouse.get_cursor()
 # スクリプトで使用時は、mouse_move_click()の定義が必要
mouse_move_click(1055, 652) # 位置は適宜変更の必要あり
mouse_move_click(1179, 695)
mouse_move_click(1021, 677)
mouse_move_click(pos_original[1], pos_original[2])

