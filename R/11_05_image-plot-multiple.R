  # 複数画像の描画
  # 11_05_image-plot-multiple.R
par(mfrow = c(3,9)); par(mar = rep(0, 4)); par(oma = rep(0, 4)) # 描画パネルの設定
as.list(imgs) |>    # walk()を使うためリストに変換
  purrr::walk(plot) # 繰り返し

