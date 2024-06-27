  # コードの説明
  # 14_06_ai-chatgpt-explain-code.R
code <- '
df <- readr::read_csv("sample.csv") |>
  filter(df, yr == 2024) |>
  arrange(name)
'
explain_code(code)

