  # 日本語でのコードの説明
  # 14_06_ai-chatgpt-explain-code-jp.R
Sys.setenv(OPENAI_RETURN_LANGUAGE = "Japanese")
code <- '
df <- readr::read_csv("sample.csv") |>
  filter(df, yr == 2024) |>
  arrange(name)
'
explain_code(code)

