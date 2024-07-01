  # seleniderでのフォームの取得と送信
  # 15_39_scrape-books-form-selenider.R
session <- selenider::selenider_session(session = "chromote", timeout = 10)
selenider::open_url(url)
  # session$driver$view()                         # ブラウザを表示するとき
selenider::s(".searchWindow-input") |>            # フォームの入力位置の要素
  selenider::elem_set_value("テキストマイニング") # フォームへの入力
selenider::s(".btn") |>                           # 検索ボタンの要素
  elem_click()                                    # 検索ボタンをクリック
selenider::ss("h3")

