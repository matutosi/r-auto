  # セッションのリセット
  # 14_04_ai-chatgpt-ask-reset-chat-session.R
ask_chatgpt("あなたは優秀な英語の教師です．")
ask_chatgpt("あなたは何の教師ですか．")
reset_chat_session() # セッションをリセット
ask_chatgpt("あなたは何の教師ですか．")

