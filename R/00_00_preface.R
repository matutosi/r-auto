  # fsパッケージのインストールと呼び出し
  # 00_01_prefase-tidyverse.R
install.packages("tidyverse") # インストール
library(tidyverse) # 呼び出し

  # 各種パッケージの一括インストール
  # 00_02_prefase-packages.R
pkgs <- 
  c("Cairo", "KeyboardSimulator", "Microsoft365R", "calendR", "chatgpt", "chromote", 
    "deeplr", "diffr", "excel.link", "extrafont", "fs", "gmailr", "googledrive", "googlesheets4", 
    "magick", "officer", "openai", "openxlsx", "pdftools", "pivotea", "pivottabler", "polite", 
    "qpdf", "readxl", "rvg", "screenshot", "selenider", "showimage", "tesseract", "textrar", 
    "tidyverse", "zipangu")
install.packages(pkgs)
