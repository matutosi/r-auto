  # CRANのパッケージを取得する関数
  # 15_22_scrape-scrape-cran-fun.R
scrape_cran_pkgs <- function(){
  url <- 
    "https://cran.r-project.org/web/packages/available_packages_by_name.html"
  html <- read_html(url)
  pkgs <-
    html |>
    html_table(header = TRUE) |>
    `[[`(_, 1) |> # [[1]]と同じ
    magrittr::set_colnames(c("pkg", "description")) |>
    dplyr::mutate(
      description = stringr::str_replace_all(description, "\n", " "))
  return(pkgs)
}

