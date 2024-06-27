  # マウス位置の取得する関数の定義
  # 06_08_kybd-mouse-record.R
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
mouse_record()
 ## Press Enter on R console
 ## 1: x = 568, y = 143
 ## Press Enter on R console
 ## 2: x = 334, y = 564
 ## Press Enter on R console
 ## 3: x = 602, y = 484

