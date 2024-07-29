  # パワーポイントへの箇条書きの追加
  # 10_07_powerpoint-list.R
ul <- 
  unordered_list(
    level_list = c(1, 2, 3),
    str_list = c("大項目", "中項目", "小項目"),
    style = list(fp_text(color = "red", font.size = 0),
                 fp_text(color = "blue", font.size = 0),
                 fp_text(color = "green", font.size = 0))
pp <- add_slide(pp)
pp <- ph_with(x = pp, value = ul, location = ph_location_type(type = "body"))
ul <- unordered_list(level_list = c(1, 2, 3),
                     str_list = c("大項目", "中項目", "小項目"))
pp <- add_slide(pp)
pp <- ph_with(x = pp, value = ul, location = ph_location_type(type = "body"))
print(pp, target = path)
  # shell.exec(path)

