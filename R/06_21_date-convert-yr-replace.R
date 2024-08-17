  # 和暦・西暦の一括変換
  # 06_21_date-convert-yr-replace.R
yr_west <- paste0(as.character(1950:2024), "年")
yr_jp <- convert_yr(yr_west, out_format = "jp")
sentence <- "昭和48年生まれは，平成30年で45歳，令和5年で50歳です．
             昭和50年生まれは，平成30年で43歳，令和5年で48歳です．" |>
  stringr::str_remove_all(" ") # 空白を削除
  # 置換するとき
pattern <- yr_west
names(pattern) <- yr_jp # ベクトルに名前を付ける
stringr::str_replace_all(sentence, pattern) |> cat()
  # 併記するとき
pattern <- paste0(stringr::str_remove(yr_west, "年"), "(", yr_jp, ")")
names(pattern) <- yr_jp # ベクトルに名前を付ける
stringr::str_replace_all(sentence, pattern) |>
  cat()

