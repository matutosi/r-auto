  # tidyverseのインストール
  # 02_01_analysis-install.R
install.packages("tidyverse")

  # tidyverseの呼び出し
  # 02_02_analysis-library.R
library(tidyverse)

  # エクセルの全シートを読み込む関数
  # 02_03_analysis-read-all-sheets-fun.R
read_all_sheets <- function(path, add_sheet_name = TRUE){
  sheets <- openxlsx::getSheetNames(path)  # シート名の一覧
  xlsx <- 
    sheets |>
    purrr::map(\(x){                       # シートごとに
      openxlsx::read.xlsx(path, sheet = x) # データの読み込み
    }) |>
    purrr::map(tibble::tibble)             # tibbleに変換
  names(xlsx) <- sheets                    # シート名
  if(add_sheet_name){                      # シート名をtibbleに追加するか
    xlsx <- purrr::map2(xlsx, sheets,
      \(.x, .y){
        dplyr::mutate(.x, sheet = .y)      # シート名の列を追加
      }
    )
  }
  return(xlsx)
}

  # 集計用データの読み込み
  # 02_04_analysis-read.R
wd <- fs::path_temp()
setwd(wd)
files <- c("answer.xlsx", "attribute.xlsx", "sales.xlsx", "unit_price.xlsx")
urls <- paste0("https://matutosi.github.io/r-auto/data/", files)
curl::multi_download(urls)
answer <- readxl::read_excel(files[1])
attribute <- readxl::read_excel(files[2])
sales <- read_all_sheets(files[3]) |> 
  dplyr::bind_rows() |>       # 結合
  dplyr::rename(shop = sheet) # 列名の変更
unit_price <- readxl::read_excel(files[4])

  # answerの概要
  # 02_05_analysis-answer.R
head(answer, 3)

  # attributeの概要
  # 02_06_analysis-attribute.R
head(attribute, 3)

  # salesの概要
  # 02_07_analysis-sales.R
head(sales, 3)

  # unit_priceの概要
  # 02_08_analysis-unit-price.R
head(unit_price, 3)

  # 横長形式への変換
  # 02_09_analysis-tidyr-pivot-wider.R
head(answer, 3)
answer <- 
  tidyr::pivot_wider(answer, names_from = item, values_from = ans)
head(answer, 3)

  # 縦長形式への変換
  # 02_10_analysis-tidyr-pivot-longer.R
head(sales, 3)
sales <- 
  tidyr::pivot_longer(sales, cols = !c(period, shop),  # ! は以外の意味
                      names_to = "item", values_to = "count")
head(sales, 3)

  # 列の縦方向への分割
  # 02_11_analysis-tidyr-separate-longer-delim.R
answer <- answer |>
  tidyr::separate_longer_delim(apps, delim = ";") |> # ";"で区切り
  tidyr::replace_na(list(apps = "-", comment = ""))  # 
head(answer, 3)

  # データフレームの結合
  # 02_12_analysis-dplyr-join.R
answer <- dplyr::left_join(attribute, answer) # id列で結合
head(answer, 3)
sales <- dplyr::left_join(sales, unit_price, by = join_by(item == item))
head(sales, 3)

  # 漏れ(欠落データ)の抽出
  # 02_13_analysis-dplyr-anti-join.R
lost <- dplyr::filter(answer, apps != "-") # apps == "-" を欠落させる
print(answer, n = 3)
print(lost, n = 3)
dplyr::anti_join(answer, lost) |> print(n = 3) # lostで欠落したもの

  # 列の選択
  # 02_14_analysis-dplyr-select.R
dplyr::select(answer, id, area, period) |> head(3)
dplyr::select(sales, -c(period, item)) |> head(3)

  # 行を抽出
  # 02_15_analysis-dplyr-filter.R
dplyr::filter(sales, 600 < price & price < 700) |> head(3)

  # 重複の除去
  # 02_16_analysis-dplyr-distinct.R
dplyr::distinct(answer, area) |> print(3)

  # 並べ替え
  # 02_17_analysis-dplyr-arrange.R
dplyr::arrange(sales, desc(count)) |> head(3)

  # 列の追加
  # 02_18_analysis-dplyr-mutate.R
dplyr::mutate(answer, id = as.numeric(id), period = as.numeric(period)) |> 
  print(n = 3)
answer |>
  dplyr::mutate(id = as.numeric(id), period = as.numeric(period)) |> 
  dplyr::mutate(ap = stringr::str_sub(apps, 1, 2), .before = 2) |> # 2列目の前
  print(n = 3)

  # 指定列の変換
  # 02_19_analysis-dplyr-mutate-all.R
answer <- dplyr::mutate_at(answer, c("id", "period", "satisfy"), as.numeric) |> 
  print(n = 3)

  # グループ化
  # 02_20_analysis-dplyr-group-by.R
dplyr::group_by(answer, area) |> print(n = 3)

  # 平均や最大値などの集計
  # 02_21_analysis-dplyr-summarise.R
dplyr::group_by(answer, area) |> 
  dplyr::summarise(m_period = mean(period), m_satisfy = mean(satisfy))

  # .byを使った平均や最大値などの集計
  # 02_22_analysis-dplyr-summarise-by.R
dplyr::summarise(answer,m_period = mean(period), m_satisfy = mean(satisfy), 
                 .by = area)

  # 数値の列の集計
  # 02_23_analysis-dplyr-summarise-if.R
dplyr::group_by(sales, item) |> 
  dplyr::summarise_if(is.numeric, max) |>
  print(n = 3)

  # 個数を数える
  # 02_24_analysis-dplyr-n.R
dplyr::group_by(answer, area) |> 
  dplyr::summarise(n = n())

  # 集計後の表示変更
  # 02_25_analysis-dplyr-summarise-pivot-wider.R
sales |>
  dplyr::summarise(sum = round(sum(count * price) / 1000), 
                   .by = c(period, shop)) |>
  tidyr::pivot_wider(names_from = shop, values_from = sum) |>
  print(n = 3)

  # 複数回答を集計する関数
  # 02_26_analysis-dplyr-count-multi-ans-fun.R
count_multi <- function(df, col, delim = "[^[:alnum:]]+", group_add = TRUE){
  df |>
    tidyr::separate_longer_delim(tidyselect::all_of(col),        # 縦に分割
                                 delim = delim) |> 
    dplyr::filter({{ col }} != "") |>                            # 空を除去
    dplyr::filter(!is.na({{ col }})) |>                          # NAを除去
    dplyr::group_by(dplyr::pick({{ col }}), .add = group_add) |> # グループ化
    dplyr::tally() |>                                            # 個数
    dplyr::filter({{ col }} != "")                               # 空を除去
}

  # 単純集計
  # 02_27_analysis-dplyr-straight-summary.R
dplyr::count(answer, area)  |> print(n = 3)  # 単数回答・単純集計
count_multi(answer, "apps") |> print(n = 3)  # 複数回答・単純集計

  # クロス集計
  # 02_28_analysis-dplyr-cross-summary.R
dplyr::count(answer, area, satisfy) |> # 単数回答・クロス集計
  tidyr::pivot_wider(names_from = area, values_from = n, values_fill = 0) |>
  print(n = 3)
answer |> # 複数回答・クロス集計
  dplyr::group_by(area) |>
  count_multi("apps", delim = ";") |>
  tidyr::pivot_wider(names_from = area, values_from = n, values_fill = 0) |>
  print(n = 3)

  # 列の順序変更と列名の変更
  # 02_29_analysis-dplyr-others.R
dplyr::relocate(answer, ans) # 出力は省略
dplyr::rename(df, ans_id = id) # 出力は省略

  # 個数を数えるショートカット
  # 02_30_analysis-dplyr-tally.R
dplyr::group_by(answer, area) |> dplyr::tally() # 出力は省略
dplyr::count(answer, area) # 出力は省略

  # 基本的な描画(箱ひげ図)
  # 02_31_analysis-ggplot-ggplot.R
sales |>
  ggplot2::ggplot(ggplot2::aes(x = item, y = count)) + 
  ggplot2::geom_boxplot()

  # ジッター・プロット
  # 02_32_analysis-ggplot-geom-jitter.R
sales |>
  ggplot2::ggplot(ggplot2::aes(item, count)) + 
  ggplot2::geom_jitter()

  # 箱ひげ図とジッター・プロットの重ね合わせ
  # 02_33_analysis-ggplot-geom-boxplot-geom-jitter.R
gg_sales <- 
  sales |>
  ggplot2::ggplot(ggplot2::aes(item, count)) + 
  ggplot2::geom_boxplot(outlier.color = NA) + # 外れ値の重複を防止
  ggplot2::geom_jitter(width = 0.3, height = 0, size = 0.3) +
  ggplot2::guides(x = ggplot2::guide_axis(n.dodge = 2)) # x軸の重なり防止
gg_sales

  # forとsubset()を使った散布図の分割
  # 02_34_analysis-ggplot-facet-for.R
par(mfcol = c(3, 3))
par(mar = rep(0.1, 4))
par(oma = rep(0.1, 4))
for(s in unique(sales$shop)){
  sales_sub <- subset(sales, shop == s)
  plot(factor(sales_sub$item), sales_sub$count)
}

  # facetによる分割して作図
  # 02_35_analysis-ggplot-facet-wrap.R
sales |>
  ggplot2::ggplot(ggplot2::aes(item, count)) + 
  ggplot2::geom_boxplot() + 
  ggplot2::facet_wrap(vars(shop))

  # 作図のファイルへの保存
  # 02_36_analysis-ggplot-ggsave.R
path <- fs::file_temp(ext = "png")
ggplot2::ggsave(path, gg_sales)

  # extrafontとCairoのインストールと呼び出し
  # 02_37_analysis-extrafont.R
install.packages("extrafont")
install.packages("Cairo")
library(extrafont)
library(Cairo)

  # フォントのインポート
  # 02_38_analysis-extrafont-font-import.R
extrafont::font_import()

  # フォントの登録
  # 02_39_analysis-extrafont-loadfonts.R
extrafont::loadfonts()

  # 利用可能なフォントの確認
  # 02_40_analysis-extrafont-font.R
extrafont::fonts()
extrafont::fonts() |>
  stringr::str_subset("Yu")

  # PDFファイルの文字化け対策
  # 02_41_analysis-ggplot-notofu.R
  # library(extrafont) # 再起動時には必要
library(Cairo)
gg_sales_cairo <- 
  gg_sales + 
  ggplot2::theme(text = ggplot2::element_text(family = "Yu Mincho"))
path <- fs::file_temp(ext = "pdf")
ggplot2::ggsave(path, gg_sales_cairo, 
  device = cairo_pdf, width = 7, height = 7)
  # shell.exec(path)

  # プロット内に日本語を入れる
  # 02_42_analysis-geom-text.R
tibble::tibble(x = 1:5, y = 1:5, label = c("あ", "い", "う", "え", "お")) |>
  ggplot2::ggplot(aes(x, y, label = label)) +
  ggplot2::geom_text(family = "Yu Mincho", size = 10)
path <- fs::file_temp(ext = "pdf")
ggplot2::ggsave(path, device = cairo_pdf)
  # shell.exec(path)

  # テーマの変更
  # 02_43_analysis-ggplot-theme.R
gg <- 
  tibble::tibble(x = rnorm(100), y = runif(100)) |>
  ggplot2::ggplot(ggplot2::aes(x, y)) +
  ggplot2::geom_point() +  # 散布図
  ggplot2::theme_bw()      # 白黒のシンプルなテーマに変更

  # データフレームのリストへの分割
  # 02_44_analysis-purrr-split-area.R
group_split(answer, area)

  # 作図の繰り返し
  # 02_45_analysis-purrr-split-imap.R
gg_sales_split <- 
  sales |>
  group_split(shop) |>
  purrr::imap(
    \(.x, .y){
      ggplot2::ggplot(.x, ggplot2::aes(period, count, group = item)) +
      ggplot2::geom_line(aes(color = item)) +
      ggplot2::theme_bw() + 
      ggplot2::theme(text = ggplot2::element_text(family = "Yu Mincho")) + 
      ggplot2::labs(title = .y)
    }
  )

  # リストになったグラフの表示
  # 02_46_analysis-purrr-split-imap-gg.R
gg_sales_split[[2]] # 2番目のグラフ

  # 複数の図の保存
  # 02_47_analysis-purrr-split-map2.R
pdfs <- 
  paste0(names(gg_sales_split), ".pdf") |>
  fs::path_temp()
purrr::map2(pdfs, gg_sales_split, ggsave, 
            device = cairo_pdf, width = 7, height = 7)
  # shell.exec(pdfs[1])

  # 2のときにエラーになる関数
  # 02_48_analysis-purrr-safely-prep.R
error_if_two <- function(x){
  if(x == 2){
    stop("エラーです")
  }else{
    return(x)
  }
}

  # 繰り返し処理のエラー対応
  # 02_49_analysis-purrr-safely.R
purrr::map(1:3, error_if_two)  # そのままのとき
error_if_two_possibly <- possibly(error_if_two, otherwise = 0) # エラー時は0
purrr::map_dbl(1:3, error_if_two_possibly)

  # 順次処理の関数の基本動作
  # 02_50_analysis-purrr-reduce-add.R
accumulate(1:4, `*`)
reduce(1:4, `*`)

  # 新しいものを追加する関数
  # 02_51_analysis-purrr-paste-if-new-fun.R
paste_if_new <- function(x, y){
  pattern <- paste0("(^|;)+", y, "(;|$)+")
  if(stringr::str_detect(x, pattern)){
    x
  }else{
    paste0(x, ";", y)
  }
}

  # 順次処理の関数
  # 02_52_analysis-purrr-reduce.R
answer |> 
  dplyr::summarise(apps = reduce(apps, paste_if_new), 
                   .by = c(area, satisfy)) |>
  print(n = 3)

