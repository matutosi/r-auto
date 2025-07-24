  # コード生成の自動化
  # 04_20_kybd-gen-code.R
for(p in pos){
  pre <- "mouse_move_click("
  mid <- ", "
  post <- ")\n"
  paste0(pre, p[1], mid, p[2], post) |>
  cat()
}

