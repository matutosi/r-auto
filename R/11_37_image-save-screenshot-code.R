  # クリップボード画像の自動保存
  # 11_37_image-save-screenshot-code.R
wd <- fs::path(fs::path_home(), "desktop")  # 保存先ディレクトリ
setwd(wd)                                   # 保存ファイルの指定
no <- stringr::str_pad(1:99, width = 2, "left", "0") # 2桁の連番
path <- paste0("clip_image_", no, ".png")
pngs <- fs::dir_ls(regexp = "\\.png")  # 既存ファイル
path <- setdiff(path, pngs)[1]         # 既存ファイル以外での1つ目

screenshot::save_clipboard_image(path)  # 画像の保存
write.table(path, "clipboard",          # ファイル名をクリップボードに保存
  quote = FALSE, row.names = FALSE, col.names = FALSE)

