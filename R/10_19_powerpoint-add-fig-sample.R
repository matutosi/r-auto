  # タイトルと画像のスライドの追加
  # 10_19_powerpoint-add-fig-sample.R
titles <- c("1枚目", "2枚目")
images <- path_images               # extract_pp_images()で抽出した画像
pp <- reduce2(titles, images,       # タイトルと画像はスライドで異なる
              add_fig, .init = pp,
              fig_full_size = TRUE) # 以下は全スライドで同じ)
path <- fs::path_temp("slide2.pptx"
print(pp, target = path)
  # shell.exec(path)

