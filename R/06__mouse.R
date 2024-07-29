  # KeyboardSimulatorのインストールと呼び出し
  # 06_01_kybd-install.R
install.packages("KeyboardSimulator")
library(KeyboardSimulator)

  # キーボードの操作
  # 06_02_kybd-keybd-press.R
keybd.press("win+left") # アプリを左側に

  # キーボードからの文字入力
  # 06_03_kybd-keybd-type.R
keybd.type_string("abc") # abcを入力
 # keybd.press("a+b+c")  # 上と同じ

  # キーボードの値一覧
  # 06_04_kybd-keyboard-value.R
dplyr::slice(keyboard_value, 85:90)

  # コマンドプロンプトの起動
  # 06_05_kybd-shell-instant.R
KeyboardSimulator::keybd.press("win+r")
Sys.sleep(0.5) # エラーの場合は長くする
KeyboardSimulator::keybd.type_string("cmd")
KeyboardSimulator::keybd.press("enter")

  # マウス位置の取得
  # 06_06_kybd-mouse-get-cursor.R
mouse.get_cursor()
 ## [1] 297  306

  # マウス位置の取得する関数
  # 06_07_kybd-mouse-record-fun.R
mouse_record <- function(n = 3, interval = -1){
  pos <- list()
  for(i in seq(n)){
    if(interval < 0){
      readline("Press Enter on R console") # クリックごと
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
  # 06_08_kybd-mouse-record.R
mouse_record()
 ## Press Enter on R console
 ## 1: x = 568, y = 143
 ## Press Enter on R console
 ## 2: x = 334, y = 564
 ## Press Enter on R console
 ## 3: x = 602, y = 484

  # マウスの位置移動
  # 06_09_kybd-mouse-move.R
mouse.move(x = 400, y = 200)
mouse.move(200, 200, duration = 1, step_ratio = 0.1)

  # マウスのクリック
  # 06_10_kybd-mouse-click.R
mouse.click(button = "left", hold = FALSE) # 既定値のクリック

  # マウスを移動してクリックする関数
  # 06_11_kybd-mouse-move-click-fun.R
mouse_move_click <- function(x, y, button = "left", hold = FALSE, 
                             sleep_sec = 0.1){
  KeyboardSimulator::mouse.move(x, y)
  KeyboardSimulator::mouse.click(button = button, hold = hold)
  Sys.sleep(sleep_sec)
}

  # 左上のファイルをダブルクリック
  # 06_12_kybd-mouse-move-click.R
mouse_move_click(50,50)
mouse_move_click(50,50)

  # 左上のファイルをドラッグして移動
  # 06_13_kybd-mouse-move-click-hold.R
mouse_move_click(50,50, hold = TRUE, sleep_sec = 0.1)
mouse_move_click(150,50)
mouse.release()

  # screenshotのインストールと呼び出し
  # 06_14_kybd-screenshot-install.R
install.packages("screenshot")
library(screenshot)

  # スクリーンショット撮影のバッチファイルのインストール
  # 06_15_kybd-screenshot-install-screenshot.R
 # fs::path_package("screenshot")にイントールされる
screenshot::install_screenshot()

  # スクリーンショット撮影
  # 06_16_kybd-screenshot.R
sc <- screenshot::screenshot()
 ## C:/Users/USERNAME/AppData/Local/Temp/RtmpkP1iLf/sc_287c4b4873da.png
imager::load.image(sc) |> plot() # imagerで読み込んで図示

  # 位置特定用の画像の準備
  # 06_17_kybd-screenshot-needle-image.R
needle_image <- magick::image_read(sc) |>
                magick::image_crop(geometry = "60x60+0+0")
plot(needle_image)
path_needle <- fs::file_temp(ext = "png")
magick::image_write(needle_image, path_needle)

  # 画像の位置特定によるマウスの移動・クリック
  # 06_18_kybd-screenshot-locate-image.R
screenshot::locate_image(needle_image = path_needle)
screenshot::locate_image(path_needle, center = FALSE)

  # USB取り出し用マウス位置の取得
  # 06_19_kybd-remove-usb-pos.R
pos <- mouse_record(n = 4)
 ## Press Enter on R consolepos # xy座標の位置は環境によって全く異なる
 ## 1: x = 1050, y = 671
 ## Press Enter on R console
 ## 2: x = 1055, y = 652
 ## Press Enter on R console
 ## 3: x = 1179, y = 695
 ## Press Enter on R console
 ## 4: x = 1021, y = 677

  # コード生成の自動化
  # 06_20_kybd-gen-code.R
for(p in pos){
  pre <- "mouse_move_click("
  mid <- ", "
  post <- ")\n"
  paste0(pre, p[1], mid, p[2], post) |>
  cat()
}
 ## mouse_move_click(225, 843)
 ## mouse_move_click(1055, 652)
 ## mouse_move_click(1179, 695)
 ## mouse_move_click(1021, 677)

  # USBの取り出しコードの例
  # 06_21_kybd-remove-usb.R
pos_original <- KeyboardSimulator::mouse.get_cursor()
 # スクリプトで使用時は，mouse_move_click()の定義が必要
mouse_move_click(225, 843) # 位置は適宜変更の必要あり
mouse_move_click(1055, 652)
mouse_move_click(1179, 695)
mouse_move_click(1021, 677)
mouse_move_click(pos_original[1], pos_original[2])

