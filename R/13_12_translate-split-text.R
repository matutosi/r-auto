  # 文への分割
  # 13_12_translate-split-text.R
result <- 
  tibble::tibble(en = split_sentence(text), 
                 jp = split_sentence(translated)) |>
  print()
 ## # A tibble: 30 × 2
 ##    en                                        jp
 ##    <chr>                                     <chr>
 ##  1 "The birch canoe slid on the smoo..."  "白樺のカヌーは滑らかな板の上..."
 ##  2 "Glue the sheet to the dark blue ..."  "紺色の背景にシートを糊付けする。"
 ##  3 "It's easy to tell the depth of a..."  "井戸の深さを知るのは簡単だ。"
 ##  4 "These days a chicken leg is a ra..."  "最近、鶏のモモ肉は珍しい料理だ。"
 ##  5 "Rice is often served in round bo..."  "ご飯は丸い茶碗に盛られること..."
 ##  6 "The juice of lemons makes fine p..."  "レモンの果汁はいいパンチを作る。"
 ##  7 "The box was thrown beside the pa..."  "箱は駐車中のトラックの横に投げら"
 ##  8 "The hogs were fed chopped corn a..."  "豚には刻んだトウモロコシと生..."
 ##  9 "Four hours of steady work faced ..."  "4時間の地道な作業が待っていた。"
 ## 10 "A large size in stockings is har..."  "ストッキングの大きいサイズはな..."
 ## # ℹ 20 more rows

