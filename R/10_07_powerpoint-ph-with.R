  # 内容の追加
  # 10_07_powerpoint-ph-with.R
pp <- ph_with(pp, value = "Rによる自動化の方法", 
              location = ph_location_type(type = "title"))
pp <- ph_with(pp, paste0("手作業", 1:5), 
              location = ph_location_label(
              ph_label = "Content Placeholder 2"))
pp <- ph_with(pp, paste0("自動化", 1:5), 
              location = ph_location_label(
              ph_label = "Content Placeholder 3"))
print(pp, target = path)
  # shell.exec(path)

