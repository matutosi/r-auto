  # 各種ファイルからPDFに変換する関数
  # 07_27_pdf-convert-fun.R
convert_app_format <- function(path, format){
  base_ext <- fs::path_ext(path)
  if (base_ext == format){  # 拡張子が入力と同じとき
    return(invisible(path)) # 終了
  }
  format_no <- set_format_no(base_ext, format)
  path <- normalizePath(path)        # Windowsの形式("\\")に変換："/"はエラー
  converted <-                       # 変換後の拡張子
    fs::path_ext_set(path, ext = format) |>
    normalizePath(mustWork = FALSE)
  officeApp <- 
    switch(base_ext,
           xlsx = "Excel.Application",
           pptx = "PowerPoint.Application",
           "Word.Application") |>
     RDCOMClient::COMCreate()
  officeApp[["Visible"]] <- TRUE        # アプリ表示
  officeApp[["DisplayAlerts"]] <- FALSE # 警告の非表示
  base_file <- switch(base_ext,
                xlsx = officeApp$workbooks()$Open(path),
                pptx = officeApp[["Presentations"]]$Open(path),
                officeApp[["Documents"]]$Open(path, ConfirmConversions = FALSE))
  base_file$SaveAs(converted, FileFormat = format_no)
  base_file$close()
  paste0("taskkill /f /im ",       # 終了コマンド
         switch(base_ext,
                xlsx = "excel",
                pptx = "powerpnt",
                "winword"),
         ".exe") |>
    system()                        # 実行
  return(fs::path(converted))
}

set_format_no <- function(base_ext, format){
  format_no <- 
    switch(base_ext,
      xlsx = switch(format,
                   pdf = 57),
      pptx = switch(format,
                    ppt = 1, rtf = 5, pptx = 11, ppsx = 28, pdf = 32,
                    wmf = 15, gif = 16, jpg = 17, png = 18, bmp = 19,
                    tif = 21, emf = 23,
                    wmv = 37, mp4 = 39),
      switch(format,
                    docx = 16, pdf = 17,
                    xps = 19, html = 20, rtf = 23, txt = 25))
}

