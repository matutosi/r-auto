  # 日付と曜日との整合性の確認
  # 04_39_date-is-correct-wday.R
is_correct_wday(dates) |>
  tibble::as_tibble() |>
  na.omit() |>
  print(n = 20)

