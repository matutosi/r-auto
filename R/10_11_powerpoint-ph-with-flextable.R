  # 整形した表の追加
  # 10_11_powerpoint-ph-with-flextable.R
  # install.package("flextable") # 必要に応じてインストール
pp <- add_slide(pp, layout = layout)
 # 表のデータに合わせる
pp <- ph_with(pp, value = "autofitで整形したirisデータ", 
              location = ph_location_type(type = "title"))
ft <- flextable::flextable(head(iris))
ft <- flextable::autofit(ft)
pp <- ph_with(pp, ft, 
              location = ph_location_label(ph_label = "Content Placeholder 2"),
              )
  # 個別に指定
pp <- add_slide(pp, layout = layout)
pp <- ph_with(pp, value = "個別に指定したirisデータ", 
              location = ph_location_type(type = "title"))
ft <- flextable::width(ft, width = 1.8)
ft <- flextable::height_all(ft, height = 0.75)
ft <- flextable::hrule(ft, rule = "exact", part = "all")
pp <- ph_with(pp, ft, 
              location = ph_location_label("Content Placeholder 2")
              )
print(pp, target = path)
  # shell.exec(path)

