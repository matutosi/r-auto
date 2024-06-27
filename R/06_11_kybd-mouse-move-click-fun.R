  # マウスを移動してクリックする関数
  # 06_11_kybd-mouse-move-click-fun.R
mouse_move_click <- function(x, y, button = "left", hold = FALSE, 
                             sleep_sec = 0.1){
  KeyboardSimulator::mouse.move(x, y)
  KeyboardSimulator::mouse.click(button = button, hold = hold)
  Sys.sleep(sleep_sec)
}

