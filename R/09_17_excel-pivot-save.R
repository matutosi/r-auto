  # ピボットテーブルの書き込み
  # 09_17_excel-pivot-save.R
df_diamonds <- 
  pt_diamonds$asDataFrame() |>
  tibble::rownames_to_column("color") |>     # 行名を列に
  tidyr::separate_wider_delim(color,         # 結果と色を別の列に
    delim = " ", names = c("calc", "color"))
file_diamonds <- fs::path_temp("df_diamonds.tsv")
readr::write_tsv(df_diamonds, file_diamonds)
  # shell.exec(file_diamonds) # 関連付けアプリで開く

