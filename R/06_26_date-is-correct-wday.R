  # 日付と曜日との整合性の確認
  # 06_26_date-is-correct-wday.R
is_correct_wday(dates) |>
  tibble::as_tibble() |>
  na.omit() |>
  print(n = 20)

