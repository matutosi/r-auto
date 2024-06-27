  # idや属性名での要素の取得
  # 15_07_scrape-html-element-id.R
html |> html_elements("#text_1") # id = "text_1"
html |> 
  html_elements(".list") |>      # class = "list"
  html_elements("option")        # さらにoptionタグで絞り込み
html |> html_elements("[href]")  # href属性

