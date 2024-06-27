  # パッケージの検索例
  # 15_24_scrape-search-cran.R
pkgs <- scrape_cran_pkgs()
pattern = stringr::regex("GPT|OpenAI", ignore_case = TRUE)
pkg_gpt <- search_cran_pkgs(pkgs, pattern)

