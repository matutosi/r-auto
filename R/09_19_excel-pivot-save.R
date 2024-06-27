  # ピボットテーブルの書き込み
  # 09_19_excel-pivot-save.R
df_diamonds <- 
  pt_diamonds$asDataFrame() |>
  tibble::rownames_to_column("color") |> # 行名を列に
  tidyr::separate(color, into = c("calc", "color")) # 結果と色を別列に
file_diamonds <- fs::path_temp("df_diamonds.tsv")
readr::write_tsv(df_diamonds, file_diamonds)
  # shell.exec(file_diamonds) # 関連付けアプリで開く

