  # 列幅を変更する関数
  # 09_25_excel-width-fun.R
set_col_width_auto <- function(wb_path){ # wb_path：ワークブックのパス(文字列)
  wb <- openxlsx::loadWorkbook(wb_path) # 読込
  for(sheet in sheets(wb)){             # シートごと
    cols <-                             # 列番号
      openxlsx::readWorkbook(wb, sheet) |>
      ncol() |> 
      seq() # seq(5)で1:5と同じ
    openxlsx::setColWidths(wb, sheet, cols, width = "auto") # 列幅の設定
  }
  openxlsx::saveWorkbook(wb, wb_path, overwrite = TRUE) # 書き込み
}

