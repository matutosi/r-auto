  # 文字列の箇条書に変換してスライドに追加
  # 10_10_powerpoint-str2ul.R
pp <- add_slide(pp)
str <- c("-大項目;--中項目;-大項目;--中項目;--中項目;---小項目;---小項目")
ul <- str2ul(str, sep = ";")
pp <- ph_with(x = pp, value = ul, location = ph_location_type(type = "body"))
print(pp, target = path)
  # shell.exec(path)

