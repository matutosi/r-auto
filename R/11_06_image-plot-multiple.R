  # 複数画像の描画
  # 11_06_image-plot-multiple.R
par(mfrow = c(3,9)) # 描画パネルの分割
par(mar = rep(0, 4))
par(oma = rep(0, 4))
imgs |>
  as.list() |> # walk()を使うためリストに変換
  purrr::walk(plot) # 繰り返し

