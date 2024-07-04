  # Geminiへの質問
  # 14_14_ai-gemini-gemini.R
  # (Geminiからの回答を読みやすく調整済み，以下同様)
prompt <- paste0("次の文章を200文字程度に要約してください．\n",text)
gemini(prompt)

