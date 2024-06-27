  # パッケージを検索する関数
  # 15_23_search_cran_pkgs-fun.R
search_cran_pkgs <- function(pkgs, pattern){
  pkgs <- 
    pkgs |>
      dplyr::filter(stringr::str_detect(pkg, pattern) |
                    stringr::str_detect(description, pattern)) |>
      `$`(_, "pkg")
  url <- "https://cran.r-project.org/web/packages/"
  urls <- paste0(url, pkgs)
  return(list(pkg = pkgs, url = urls))
}

