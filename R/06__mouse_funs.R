  # マウス位置の取得する関数
  # 06_08_kybd-mouse-record-fun.R
mouse_record <- function(n = 3, interval = -1){
  pos <- list()
  for(i in seq(n)){
    if(interval < 0){
      readline("Press Enter on R console")
    }else{
      Sys.sleep(interval)
    }
    pos[[i]] <- KeyboardSimulator::mouse.get_cursor()
    position <- paste0(i, ": x = ", pos[[i]][1], ", y = ", pos[[i]][2], "\n")
    cat(position)
  }
  return(invisible(pos))
}
  # マウスを移動してクリックする関数
  # 06_12_kybd-mouse-move-click-fun.R
mouse_move_click <- function(x, y, button = "left", hold = FALSE, 
                             sleep_sec = 0.1){
  KeyboardSimulator::mouse.move(x, y)
  KeyboardSimulator::mouse.click(button = button, hold = hold)
  Sys.sleep(sleep_sec)
}
