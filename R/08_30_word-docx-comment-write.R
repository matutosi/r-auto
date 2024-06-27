  # コメントの保存
  # 08_30_word-docx-comment-write.R
comment_path <- fs::path_temp("comment.xlsx")
cumulative_paste <- function(x, y){
  if(x == y){    # xとyが同じなら
    x            #   xのまま
  }else{         # xとyが異なれば
    paste0(x, y) #   xとyを貼り付け
  }
}
comment |>
  tidyr::unnest_longer(-comment_id) |> 
  dplyr::summarise(
    .by = c(comment_id, author, initials, date),  # コメントでグループ化
    text = reduce(text, cumulative_paste),
    commented_text = reduce(commented_text, cumulative_paste)) |> 
  openxlsx::write.xlsx(comment_path)
wb <- openxlsx::loadWorkbook(comment_path) # ワークブック読み込み
openxlsx::setColWidths(wb, 1, cols = 1:7, width = "auto")  # 列幅の変更
openxlsx::saveWorkbook(wb, comment_path, overwrite = TRUE)  # ワークブックの書き込み
  # shell.exec(comment_path)

