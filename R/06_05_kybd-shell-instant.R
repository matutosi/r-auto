  # コマンドプロンプトの起動
  # 06_05_kybd-shell-instant.R
KeyboardSimulator::keybd.press("win+r")
Sys.sleep(0.5) # エラーの場合は長くする
KeyboardSimulator::keybd.type_string("cmd")
KeyboardSimulator::keybd.press("enter")

