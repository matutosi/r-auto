  # 1年後の日付への更新
  # 06_35_date-same-pos-next-yr-example.R
sentence <- "大学祭は，2024年10月26日と10月27日に開催します．"
days_this_yr <- extract_date_ish(sentence)
days_next_yr <-
  days_this_yr |>
  date_ish2date() |>
  same_pos_next_yr(out_format = "west") |>
  rlang::set_names(days_this_yr) # 名前が置換前，値が置換後
sentence |>
  stringr::str_replace_all(days_next_yr)

