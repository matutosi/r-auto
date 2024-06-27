  # アニメーション化
  # 11_47_image-morph-animate.R
animated <- fs::path_temp("animated.gif")
mor <- 
  c(imgs[22], imgs[9], imgs[12], imgs[22]) |>
  image_trim() |>           # 余白の除去
  image_resize("x200") |>   # サイズ合わせ
  image_morph(10) |>        # 中間画像の生成
  image_animate(fps = 5) |> # アニメーション化
  image_write(animated)
  # shell.exec(animated)

