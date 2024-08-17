  # 文字列を比較して異なるときのみ貼り付ける関数
  # 08_16_word-cumulative-paste-fun.R
cumulative_paste <- function(x, y){
  if(x == y){    # xとyが同じなら
    x            #   xのまま
  }else{         # xとyが異なれば
    paste0(x, y) #   xとyを貼り付け
  }
}

