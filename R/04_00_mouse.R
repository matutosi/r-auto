  # KeyboardSimulatorのインストールと呼び出し
  # 04_01_kybd-install.R
install.packages("KeyboardSimulator")
library(KeyboardSimulator)

  # キーボードの操作
  # 04_02_kybd-keybd-press.R
keybd.press("win+left") # アプリを左側に

  # キーボードからの文字入力
  # 04_03_kybd-keybd-type.R
keybd.type_string("abc") # abcを入力

  # キーボードの値一覧
  # 04_04_kybd-keyboard-value.R
dplyr::slice(keyboard_value, 85:90)

  # コマンドプロンプトの起動
  # 04_05_kybd-shell-instant.R
KeyboardSimulator::keybd.press("win+r")
Sys.sleep(0.5) # エラーが出る場合は長くする
KeyboardSimulator::keybd.type_string("cmd")
KeyboardSimulator::keybd.press("enter")

  # マウス位置の取得
  # 04_06_kybd-mouse-get-cursor.R
mouse.get_cursor()

  # マウス位置の取得する関数
  # 04_07_kybd-mouse-record-fun.R
mouse_record <- function(n = 3, interval = -1){
  pos <- list()
  for(i in seq(n)){
    if(interval < 0){
      readline("Press Enter on R console") # Rの画面でEnterを押す
    }else{
      Sys.sleep(interval)                  # 一定時間ごと
    }
    pos[[i]] <- KeyboardSimulator::mouse.get_cursor()
    position <- paste0(i, ": x = ", pos[[i]][1], ", y = ", pos[[i]][2], "\n")
    cat(position)
  }
  return(invisible(pos))
}

  # マウス位置の取得
  # 04_08_kybd-mouse-record.R
mouse_record()

  # マウスの位置移動
  # 04_09_kybd-mouse-move.R
mouse.move(x = 400, y = 200)
mouse.move(200, 200, duration = 1, step_ratio = 0.1)

  # マウスのクリック
  # 04_10_kybd-mouse-click.R
mouse.click(button = "left", hold = FALSE) # 既定値のクリック

  # マウスを移動してクリックする関数
  # 04_11_kybd-mouse-move-click-fun.R
mouse_move_click <- function(x, y, button = "left", hold = FALSE, 
                             sleep_sec = 0.1){
  KeyboardSimulator::mouse.move(x, y)
  KeyboardSimulator::mouse.click(button = button, hold = hold)
  Sys.sleep(sleep_sec)
}

  # 左上のファイルをダブルクリック
  # 04_12_kybd-mouse-move-click.R
mouse_move_click(50,50)
mouse_move_click(50,50)

  # 左上のファイルをドラッグして移動
  # 04_13_kybd-mouse-move-click-hold.R
mouse_move_click(50,50, hold = TRUE, sleep_sec = 0.1)
mouse_move_click(150,150)
mouse.release()

  # screenshotのインストールと呼び出し
  # 04_14_kybd-screenshot-install.R
install.packages("screenshot")
library(screenshot)

  # スクリーンショット撮影のバッチファイルのインストール
  # 04_15_kybd-screenshot-install-screenshot.R
screenshot::install_screenshot()

  # スクリーンショット撮影
  # 04_16_kybd-screenshot.R
sc <- screenshot::screenshot()
magick::image_read(sc) |> plot() # 読み込んで図示

  # 位置特定用の画像の準備
  # 04_17_kybd-screenshot-needle-image.R
needle_image <- magick::image_read(sc) |>
                magick::image_crop(geometry = "60x60+0+0")
plot(needle_image)
path_needle <- fs::file_temp(ext = "png")
magick::image_write(needle_image, path_needle)

  # 画像の位置特定
  # 04_18_kybd-screenshot-locate-image.R
screenshot::locate_image(needle_image = path_needle)
screenshot::locate_image(path_needle, center = FALSE)

  # USB取り出し用マウス位置の取得
  # 04_19_kybd-remove-usb-pos.R
pos <- mouse_record(n = 4)

  # コード生成の自動化
  # 04_20_kybd-gen-code.R
for(p in pos){
  pre <- "mouse_move_click("
  mid <- ", "
  post <- ")\n"
  paste0(pre, p[1], mid, p[2], post) |>
  cat()
}

  # USBの取り出しコードの例
  # 04_21_kybd-remove-usb.R
pos_original <- KeyboardSimulator::mouse.get_cursor()
 # スクリプトで使用するときは、mouse_move_click()の定義が必要
mouse_move_click(1055, 652) # 位置は適宜変更の必要あり
mouse_move_click(1179, 695)
mouse_move_click(1021, 677)
mouse_move_click(pos_original[1], pos_original[2])

