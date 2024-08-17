  # タイトルと画像のスライドの追加(擬似コード)
  # 10_19_powerpoint-add-fig-sample.R
titles <- c("1枚目" , "2枚目" , "3枚目")
images <- c("01.png", "02.png", "03.png")
pp <- reduce2(titles, images,       # タイトルと画像はスライドで異なる
              add_fig, .init = pp,
              fig_full_size = TRUE) # 以下は全スライドで同じ)

