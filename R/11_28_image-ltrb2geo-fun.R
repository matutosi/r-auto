  # 左上・右下の位置をgeometryに変換する関数
  # 11_28_image-ltrb2geo-fun.R
ltrb2geo <- function(left_top, right_bottom){
    left <- left_top[1]
    top <- left_top[2]
    right <- right_bottom[1]
    bottom <- right_bottom[2]
    geometry <- paste0(right - left, "x", bottom - top, "+", left, "+", top)
    return(geometry)
}

