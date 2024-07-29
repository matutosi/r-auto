  # スライドに画像を追加
  # 10_12_powerpoint-ph-with-img.R
url <- "https://matutosi.github.io/r-auto/data/r_gg.png"
path_img <- fs::path_temp("r_gg.png")
curl::curl_download(url, path_img) # urlからPDFをダウンロード
  # ph_location_fullsize()：スライド全体
pp <- add_slide(pp)
pp <- ph_with(pp, 
              value = external_img(path_img),
              location = ph_location_fullsize())
pp <- ph_with(pp, value = "ph_location_fullsize()：\nスライド全体", 
              location = ph_location_type(type = "title"))
  # use_loc_size = TRUE：指定位置全体
pp <- add_slide(pp)
pp <- ph_with(pp, 
              value = external_img(path_img),
              location = ph_location_type(type = "body"), use_loc_size = TRUE)
pp <- ph_with(pp, value = "use_loc_size = TRUE：\n指定位置全体", # \nで改行
              location = ph_location_type(type = "title"))
  # guess_size = TRUE：画像のもとの大きさ
pp <- add_slide(pp)
pp <- ph_with(pp, 
              value = external_img(path_img, guess_size = TRUE),
              location = ph_location_type(type = "body"), use_loc_size = FALSE)
pp <- ph_with(pp, value = "guess_size = TRUE：\n画像のもとの大きさ", 
              location = ph_location_type(type = "title"))
  # widthとheightで大きさ指定
pp <- add_slide(pp)
pp <- ph_with(pp, 
              value = external_img(path_img, width = 5, height = 5),
              location = ph_location_type(type = "body"),
              use_loc_size = FALSE)
pp <- ph_with(pp, value = "widthとheightで\n大きさ指定", 
              location = ph_location_type(type = "title"))
print(pp, target = path)
  # shell.exec(path)

