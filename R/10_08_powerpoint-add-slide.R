  # スライドの追加
  # 10_08_powerpoint-add-slide.R
pp <- read_pptx() # 新規作成
layout <- "Two Content"
pp <- add_slide(pp, layout = layout)
path <- fs::path_temp("temp.pptx")
print(pp, target = path)
  # shell.exec(path)

