  # クリップボード画像の自動保存
  # 11_54_img-save-screenshot-code.R
  # 保存先ディレクトリ
wd <- fs::path(fs::path_home(), "desktop")
setwd(wd)
  # 保存ファイルの指定
no <- stringr::str_pad(1:99, width = 2, side = "left", pad = "0") # 2桁の連番
path <- paste0("clip_image_", no, ".png")
pngs <- fs::dir_ls(regexp = "\\.png")  # 既存ファイル
path <- setdiff(path, pngs)[1] # 既存ファイル以外での1つ目
  # 画像の保存
screenshot::save_clipboard_image(path)
 # ファイル名をクリップボードに保存
write.table(path, "clipboard", quote = FALSE, row.names = FALSE, col.names = FALSE)

