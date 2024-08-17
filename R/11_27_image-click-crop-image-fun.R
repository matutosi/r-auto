  # 指定範囲を切り取る関数
  # 11_27_image-click-crop-image-fun.R
click_crop_image <- function(path){
  img <- magick::image_read(path)                  # 読み取り
  pos <- click_locate_image(img)                   # 切り取り位置
  geometry <- ltrb2geo(pos[[1]], pos[[2]])         # 位置の変換
  img_croped <- magick::image_crop(img, geometry)  # 切り取り
  path_croped <-                                   # 保存ファイル
    fs::path(fs::path_dir(path), paste0("croped_", fs::path_file(path = path)))
  magick::image_write(img_croped, path_croped)     # 保存
  return(list(path_croped, geometry))
}

