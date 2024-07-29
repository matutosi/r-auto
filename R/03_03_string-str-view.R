  # マッチ箇所の明示
  # 03_03_string-str-view.R
str <- c("今日はいい天気です．")
pattern <- "いい天気"
str_view(str, pattern)
c(str, "明日もいい天気かな．明後日はいい天気でしょう．") |>
  str_view(pattern)

