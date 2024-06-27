  # 雨雲の動きを開く
  # 15_40_scrape-jma-open-url.R
latitude <- "34.72"
longitude <- "135.30"
https://www.jma.go.jp/bosai/nowc/#lat:34.719745/lon:135.300064/zoom:12/colordepth:normal/elements:hrpns&slmcs&slmcs_fcst
zoom <- "12"
url <- 
  paste0("https://www.jma.go.jp/bosai/nowc/#",
         "lat:", latitude, "/lon:", longitude, "/zoom:", zoom, 
         "/colordepth:normal/elements:hrpns&slmcs&slmcs_fcst")
session <- selenider_session(session = "chromote", timeout = 10)
open_url(url)
session$driver$view()

