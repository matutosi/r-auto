  # 広告非表示をクリック
  # 15_40_scrape-jma-elem-click-1.R
mdc_btn <- selenider::s("div.mdc-button__label")
if(selenider::is_present(mdc_btn)){ # "div.mdc-button__label"があれば
  selenider::elem_click(mdc_btn)
}

