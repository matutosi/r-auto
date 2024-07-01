  # Title and Contentのレイアウトでタイトルと画像を挿入する関数
  # 10_14_powerpoint-add-fig-fun.R
add_fig <- function(pp, title = "", path_img, fig_full_size = FALSE,
                    conter_horizontal = TRUE, conter_vertical = TRUE){
  # レイアウト・設置場所
  name <- "Title and Content"
  ph_label <- "Content Placeholder 2"
  # スライドのサイズ
  ss <- slide_size(pp)
  # 配置場所のサイズ
  cont_ph <- 
    layout_properties(pp) |>
    dplyr::filter(name == {{name}} & ph_label == {{ph_label}})
  if(fig_full_size){
    offx <- 0
  }else{
    offx <- cont_ph$offx
  }
  offy <- cont_ph$offy
  # 配置サイズ：全体 - offset
  w_cont <- ss$width  - offx * 2 # 幅，* 2：左右分
  h_cont <- ss$height - offy     # 高さ
  # 画像のサイズ
  img <- magick::image_read(path_img)
  w_img <- magick::image_info(img)$width
  h_img <- magick::image_info(img)$height
  # 縦横比
  ratio_img <- w_img / h_img      # 画像
  ratio_cont <- w_cont / h_cont   # 配置場所
  ratio <- ratio_img / ratio_cont # 画像と配置場所の比率
    # 縦長・横長での補正
  if(ratio > 1){
    h_cont <- h_cont / ratio # 図が横長
  }else{
    w_cont <- w_cont * ratio # 図が縦長
  }
  # 補正
  if(conter_horizontal){ # 水平方向
    offx <- (ss$width - w_cont) / 2
  } 
  if(conter_vertical){   # 垂直方向
    offy <- (offy + ss$height - h_cont) / 2
  }
  # スライドの追加
  pp <- add_slide(pp, layout = "Title and Content")
  # 画像の追加
  pp <- ph_with(pp, 
                value = external_img(path_img),
                location = ph_location(left = offx, top = offy,
                                       width = w_cont, height = h_cont))
  # タイトルの追加
  pp <- ph_with(pp, value = title,
                location = ph_location_type(type = "title"))
  return(pp)
}

