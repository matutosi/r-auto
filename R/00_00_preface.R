  # tidyverseのインストールと呼び出し
  # 00_01_tidyverse.R
install.packages("tidyverse") # インストール
library(tidyverse)            # 呼び出し

  # 各種パッケージの一括インストール
  # 00_01_install-packages.R
pkgs_cran <- 
  c("Cairo", "KeyboardSimulator", "Microsoft365R", "calendR", "chatgpt", "chromote", 
    "deeplr", "diffr", "excel.link", "extrafont", "flextable", "fs", 
    "gmailr", "googledrive", "googlesheets4", "magick", "officer", "openai", "openxlsx", 
    "pdftools", "pivotea", "pivottabler", "polite", "qpdf", "readxl", "remotes", "rvg", 
    "screenshot", "selenider", "showimage", "tesseract", "textrar", "tidyverse", "zipangu")
install.packages(pkgs_cran)
pkgs_github <- c("jhk0530/gemini.R", "omegahat/RDCOMClient")
remotes::install_github(pkgs_github)  # RToolsが必要

  # コード表記の見本
  # 00_03_code-example.R
ls("package:fs") |> stringr::str_subset("^dir") # ディテクトリ操作
