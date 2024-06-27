  # コード生成の自動化
  # 06_21_kybd-gen-code.R
for(p in pos){
  pre <- "mouse_move_click("
  mid <- ", "
  post <- ")\n"
  paste0(pre, p[1], mid, p[2], post) |>
  cat()
}
 ## mouse_move_click(225, 843)
 ## mouse_move_click(1055, 652)
 ## mouse_move_click(1179, 695)
 ## mouse_move_click(1021, 677)

