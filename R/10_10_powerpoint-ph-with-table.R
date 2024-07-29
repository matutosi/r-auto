  # 表の追加
  # 10_10_powerpoint-ph-with-table.R
layout <- "Title and Content"
pp <- add_slide(pp, layout = layout)
pp <- ph_with(pp, value = "みんな大好きirisデータ", 
              location = ph_location_type(type = "title"))
pp <- ph_with(pp, head(iris), 
              location = ph_location_label(ph_label = "Content Placeholder 2"))
print(pp, target = path)
  # shell.exec(path)

