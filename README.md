# Rによる自動化・効率化レシピ集

このページは，[「Rによる自動化・効率化レシピ集」](https://www.morikita.co.jp/books/mid/085831)
(松村 俊和，2025，森北出版)のサポートページです．

書籍の紹介記事(note)

- [その1(目次)](https://note.com/morikita/n/n91cc7dc150af)
- [その2(インタビュー)](https://note.com/morikita/n/nae210c70d90c)

<img src="r-auto.jpg" width="300"/>

## 正誤表

「Rによる自動化・効率化レシピ集」(https://www.morikita.co.jp/books/mid/085831) のタブ「正誤表」でご覧ください．

## コード

本文のコードは以下にあります．

<https://github.com/matutosi/r-auto/tree/main/R/>

-   01_01_CODE-NAME.R など：コード番号別のファイル   
-   01_00_CHAPTER.Rなど：章ごとにまとめたファイル   
-   02_00_CHAPTER_funs.Rなど：章内の全関数   


次のコードで章ごとにまとめたファイルや章内の全関数をダウンロード可能です．

```{r}
  # 章ごとにまとめたファイル，章内の全関数のダウンロード
  # URLとドメインがサポートページとは異なります

  # ダウンロード先の設定
  # wd <- fs::path_home("desktop") # デスクトップの場合
  # setwd(wd)

  # 章の名前
chap_names <-
  c("preface", "file", "analysis", "command", "mouse", "string", "date", 
    "pdf", "word", "excel", "powerpoint", "image", "mail", "translate", "ai", "scrape")

  # 章ごとにまとめたファイル
chap_files <- 
  stringr::str_pad(0:15, 2, "left", "0") |>
  paste0("_00_",  chap_names, ".R")
paste0("https://matutosi.github.io/r-auto/R/", chap_files) |>
  curl::multi_download()

  # 章内の全関数
chap_funs <- 
  stringr::str_pad(0:15, 2, "left", "0") |>
  paste0("_00_",  chap_names, "_funs.R")
paste0("https://matutosi.github.io/r-auto/R/", chap_funs) |>
  curl::multi_download()
```


各章の関数を直接呼び出す場合は，以下を参考にしてください．

```{r}
  # URLとドメインがサポートページとは異なります
  # 注意：*_funs.R内の関数が，既存の関数を上書きする可能性があります
source("https://matutosi.github.io/r-auto/R/02_00_analysis_funs.R") # Chapter 2の全関数
```


## データ

本文で使用してるデータは以下にあります．

<https://github.com/matutosi/r-auto/tree/main/data/>

各章に記載のコードからデータをダウンロード可能です．


## リンク集

| 関連章 | 内容 | URL |
|-----------------------------------|------------------|------------------|
| 全体 | サポートページ                     | <https://github.com/matutosi/r-auto/> |
| 全体 | コード                             | <https://github.com/matutosi/r-auto/tree/main/R/> |
| 全体 | 使用データ                         | <https://github.com/matutosi/r-auto/tree/main/data/> |
| 全体 | R for Data science                 | <https://r4ds.hadley.nz/> |
| 全体 | tidyverse                          | <https://www.tidyverse.org/> |
| 1    | ファイル関連のコマンド比較         | <https://cran.r-project.org/web/packages/fs/vignettes/function-comparisons.html> |
| 7,14 | RTools                             | <https://cran.r-project.org/bin/windows/Rtools/> |
| 11   | 伊良部島 海遊びガイド シャーカン   | <https://sha-kan.jp/> |
| 12   | Google Could                       | <https://console.cloud.google.com/> |
| 13   | DeepL                              | <https://www.deepl.com/ja/pro/> |
| 13   | TexTra                             | <https://mt-auto-minhon-mlt.ucri.jgn-x.jp/> |
| 14   | OpenAI                             | <https://auth.openai.com/log-in> |
| 14   | Google AI Studio                   | <https://aistudio.google.com/> |
| 14   | 青空文庫「学問の自由」(寺田 寅彦)  | <https://www.aozora.gr.jp/cards/000042/files/43535_24583.html> |
| 15   | CRANのパッケージ一覧               | <https://cran.r-project.org/web/packages/available_packages_by_name.html> |
| 15   | 森北出版                           | <https://www.morikita.co.jp/> |
| 15   | 気象庁の今後の雨                   | <https://www.jma.go.jp/bosai/kaikotan/> |
| 15   | 気象庁の雨雲の動き                 | <https://www.jma.go.jp/bosai/nowc/> |



各種パッケージ

| 関連章 | パッケージ                       | URL |
|-----------------------------------|------------------|------------------|
| 1    | fs                                 | <https://fs.r-lib.org/> |
| 2    | tidyr                              | <https://tidyr.tidyverse.org/> |
| 2    | dplyr                              | <https://dplyr.tidyverse.org/> |
| 2    | ggplot2                            | <https://ggplot2-book.org/> |
| 2    | Cairo                              | <https://www.rforge.net/Cairo/docs/index.html> |
| 2    | extrafont                          | <https://github.com/wch/extrafont> |
| 2    | purrr                              | <https://purrr.tidyverse.org/> |
| 4    | KeyboardSimulator                  | <https://github.com/ChiHangChen/KeyboardSimulator> |
| 5    | stringr                            | <https://stringr.tidyverse.org/> |
| 5    | stringi                            | <https://stringi.gagolewski.com/> |
| 5    | diffr                              | <https://github.com/muschellij2/diffr> |
| 6    | lubridate                          | <https://lubridate.tidyverse.org/> |
| 6    | zipangu                            | <https://uribo.github.io/zipangu/> |
| 6    | calendR                            | <https://r-coder.com/calendar-plot-r/> |
| 7    | pdftools                           | <https://docs.ropensci.org/pdftools/> |
| 7    | qpdf                               | <https://docs.ropensci.org/qpdf/> |
| 7    | RDCOMClient                        | <https://github.com/omegahat/RDCOMClient> |
| 8,10 | officeverse(officer)               | <https://ardata-fr.github.io/officeverse/> |
| 9    | readr                              | <https://cran.r-project.org/web/packages/readr/readme/README.html> |
| 9    | readxl                             | <https://readxl.tidyverse.org/> |
| 9    | excel.link                         | <https://github.com/gdemin/excel.link> |
| 9    | openxlsx                           | <https://ycphs.github.io/openxlsx/index.html> |
| 9    | pivotea                            | <https://matutosi.github.io/pivotea/> |
| 9    | pivottabler                        | <https://github.com/cbailiss/pivottabler> |
| 9    | googledrive                        | <https://googledrive.tidyverse.org/> |
| 10   | flextable                          | <https://ardata-fr.github.io/flextable-book/> |
| 11   | magick                             | <https://docs.ropensci.org/magick/> |
| 11   | screenshot                         | <https://matutosi.github.io/screenshot/> |
| 12   | Microsoft365R                      | <https://github.com/Azure/Microsoft365R> |
| 12   | gmailr                             | <https://gmailr.r-lib.org/> |
| 13   | deeplr                             | <https://github.com/zumbov2/deeplr> |
| 13   | textrar                            | <https://matutosi.github.io/textrar/> |
| 14   | chatgpt                            | <https://github.com/jcrodriguez1989/chatgpt> |
| 14   | openai                             | <https://irudnyts.github.io/openai/> |
| 14   | gemini.R                           | <https://github.com/jhk0530/gemini.R> |
| 15   | polite                             | <https://dmi3kno.github.io/polite/> |
| 15   | rvest                              | <https://rvest.tidyverse.org/> |
| 15   | selenider                          | <https://ashbythorpe.github.io/selenider/> |
| 15   | chromote                           | <https://rstudio.github.io/chromote/> |
| 15   | showimage                          | <https://github.com/r-lib/showimage#readme> |


## 質問

質問は，issuesか電子メールでお送り下さい．

<https://github.com/matutosi/r-auto/issues>

[matutosi\@gmail.com](mailto:matutosi@gmail.com)

## 引用

松村 俊和. 2025. Rによる自動化・効率化レシピ集. 森北出版.
