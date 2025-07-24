  # 1年後の日付への更新
  # 06_34_date-same-pos-next-yr-example.R
sentence <- "大学祭「よつば祭」は、2024年10月26日と2024年10月27日に開催します。"
days_this_yr <- extract_date_ish(sentence) # 文章から日付っぽい文字列を抽出
days_next_yr <-
  days_this_yr |>
  date_ish2date() |>
  same_pos_next_yr(out_format = "west") |>
  rlang::set_names(days_this_yr) # 名前が置換前、値が置換後
sentence |>
  stringr::str_replace_all(days_next_yr)

