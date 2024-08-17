  # 雨雲の動きの動画の取得
  # 15_43_scrape-jma-whole-game.R
scrape_jma <- function(url){
  session <- selenider::selenider_session(session = "chromote", timeout = 10)
  selenider::open_url(url)
  selenider::s("div.mdc-button__label") |> 
    selenider::elem_click()
  pngs <- list()
  n <- 13
  for(i in 1:n){
    no <- stringr::str_pad(i, width = 2, side = "left", pad = "0")
    png <- fs::path_temp(paste0(no, ".png"))
    pngs[[i]] <- selenider::take_screenshot(png)
    move_forward <- "/html/body/div[2]/div[1]/div[3]/div[1]/button[2]"
    if(i < n){
      selenider::s(xpath = move_forward) |> 
        selenider::elem_click()
    }
  }
  rain_gif <- fs::path_home("desktop/rain.gif")
  pngs |>
    unlist() |>
    magick::image_read() |>
    magick::image_animate(fps = 2) |>
    magick::image_write(rain_gif)
    # shell.exec(rain_gif)
  return(rain_gif)
}

