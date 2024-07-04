  # パワーポイントを画像・PDF・動画に変換する関数
  # 10_29_powerpoint-pp2img-fun.R
pp2ext <- function(path, format = "png"){
  format_no <- switch(format,
                      ppt = 1, rtf = 5, pptx = 11, ppsx = 28, pdf = 32, 
                      wmf = 15, gif = 16, jpg = 17, png = 18, bmp = 19,
                      tif = 21, emf = 23,
                      wmv = 37, mp4 = 39)
  path <- normalizePath(path)                               # Windows形式
  converted <- 
    fs::path_ext_remove(path) |>                            # 拡張子除去
    normalizePath(mustWork = FALSE)
  ppApp <- RDCOMClient::COMCreate("PowerPoint.Application") # パワーポイント
  ppApp[["DisplayAlerts"]] <- FALSE                         # 警告を非表示
  pp <- ppApp[["Presentations"]]$Open(path)                 # ファイルを開く
  pp$SaveAs(converted, FileFormat = format_no)              # 指定形式で保存
  pp$close()
  cmd <- "taskkill /f /im powerpnt.exe"                     # 終了コマンド
  system(cmd)                                               # コマンド実行
  if(format %in% c("ppt", "rtf", "pptx", "ppsx", "pdf")){   # 拡張子の設定
    converted <- fs::path_ext_set(converted, format)
  }
  return(converted)
}

