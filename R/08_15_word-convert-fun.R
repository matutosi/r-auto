  # ワードと各種形式との相互変換の関数
  # 08_15_word-convert-fun.R
convert_docs <- function(path, format){
  if (fs::path_ext(path) == format){ # 拡張子が入力と同じとき
    return(invisible(path))          # 終了
  }
  format_no <- switch(format,        # 拡張子ごとに番号に変換
                      docx = 16, pdf = 17,
                      xps = 19, html = 20, rtf = 23, txt = 25)
  path <- normalizePath(path)        # Windowsの形式に変換
  converted <- 
    fs::path_ext_set(path, ext = format) |> # 変換後の拡張子
    normalizePath(mustWork = FALSE)
  # ワードの操作
  wordApp <- RDCOMClient::COMCreate("Word.Application")
  wordApp[["Visible"]] <- FALSE            # TRUE：ワードの可視化
  wordApp[["DisplayAlerts"]] <- FALSE      # TRUE：警告の表示
  doc <- wordApp[["Documents"]]$Open(path, # ファイルを開く
                                     ConfirmConversions = FALSE)
  doc$SaveAs2(converted, FileFormat = format_no) # 名前をつけて保存
  doc$close()
  cmd <- "taskkill /f /im word.exe"        # 終了コマンド
  system(cmd)                              # コマンド実行
  return(converted)
}

