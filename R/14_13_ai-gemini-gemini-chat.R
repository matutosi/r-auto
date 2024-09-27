  # Geminiへの連続的な質問
  # 14_13_ai-gemini-gemini-chat.R
chat <- gemini_chat(prompt)
chat$outputs
prompt <- "要約をさらに短くして、1文にまとめてください。"
chat <- gemini_chat(prompt, chat$history)
chat$outputs
prompt <- "文章には、自由な研究には何が重要だと書かれていますか。"
chat <- gemini_chat(prompt, chat$history)
chat$outputs

