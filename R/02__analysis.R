  # tidyverseのインストール
  # 02_01_analysis-install.R
install.packages("tidyverse")

  # tidyverseの呼び出し
  # 02_02_analysis-library.R
library(tidyverse)

  # 集計用データの読み込み
  # 02_03_analysis-read.R
wd <- fs::path_temp()
setwd(wd)
files <- c("answer.xlsx", "attribute.xlsx", "sales.xlsx", "unit_price.xlsx")
urls <- paste0("https://matutosi.github.io/r-auto/data/", files)
curl::multi_download(urls)
answer <- readxl::read_excel(files[1])
attribute <- readxl::read_excel(files[2])
sales <- read_all_sheets(files[3]) |> dplyr::bind_rows()
unit_price <- readxl::read_excel(files[4])

  # answerの概要
  # 02_04_analysis-answer.R
head(answer, 5)

  # attributeの概要
  # 02_05_analysis-attribute.R
head(attribute, 5)

  # salesの概要
  # 02_06_analysis-sales.R
head(sales, 5)

  # unit_priceの概要
  # 02_07_analysis-unit-price.R
head(unit_price, 5)

  # tibble()によるtibbleの生成
  # 02_08_analysis-tibble-tibble.R
set.seed(12)
n <- 100
id <- seq(n)
area <- sample(
  c("北海道・東北", "関東", "中部", "近畿", "中国・四国", "九州・沖縄"), 
    n, replace = TRUE)
period <- sample(1:30, n, replace = TRUE, prob = 30:1)
tibble::tibble(id, area, period) |>
  head(5)

  # tribble()によるtibbleの生成
  # 02_09_analysis-tibble-tribble.R
tibble::tribble(
  ~item, ~price,
  "和定食"         , 650,
  "洋定食"         , 700,
  "カレー"         , 600,
  "カツ丼"         , 650,
  "うどん"         , 500,
  "蕎麦"           , 500,
  "オムライス"     , 600,
  "チャーハン"     , 630,
  "ドリア"         , 700,
  "ピザ"           , 740,
  "スパゲティ"     , 710,
  "サンドウィッチ" , 450 )  |>
   head(3)

  # データフレームのへのtibbleの変換
  # 02_10_analysis-tibble-as-tibble.R
data(iris)
class(iris)
iris # 全部表示される
iris_tibble <- tibble::as_tibble(iris)
class(iris_tibble)
iris_tibble # 最初の部分が表示される

  # 横長形式への変換
  # 02_11_analysis-tidyr-pivot-wider.R
head(answer, 5)
answer <- 
  tidyr::pivot_wider(answer, names_from = item, values_from = ans)
head(answer, 5)

  # 縦長形式への変換
  # 02_12_analysis-tidyr-pivot-longer.R
head(sales, 5)
sales <- 
  tidyr::pivot_longer(sales, cols = !c(period, sheet),  # ! は以外の意味
                      names_to = "item", values_to = "count")
head(sales, 5)

  # 列の分割
  # 02_13_analysis-tidyr-separate.R
tidyr::separate(sales, col = period, into = c("year", "month"), sep = "-") |>
  head(3)

  # 列の統合
  # 02_14_analysis-tidyr-unite.R
tidyr::unite(sales, col = "shop_item", sheet, item, sep = "-") |> head(3)
tidyr::unite(sales, "shop_item", sheet, item, remove = FALSE) |> head(3)

  # 列の縦方向への分割
  # 02_15_analysis-tidyr-separate-rows.R
answer <- tidyr::separate_rows(answer, apps, sep = ";")
head(answer, 5)

  # NAの置換
  # 02_16_analysis-tidyr-replace-na.R
answer <- replace_na(answer, list(apps = "-", comment = "-"))
head(answer, 5)

  # データフレームの結合
  # 02_17_analysis-dplyr-join.R
answer <- dplyr::left_join(attribute, answer) # id列で結合
head(answer, 3)
sales <- dplyr::left_join(sales, unit_price, by = join_by(item == item))
head(sales, 3)

  # 漏れ(欠落データ)の抽出
  # 02_18_analysis-dplyr-anti-join.R
lost <- dplyr::filter(answer, apps != "-") # apps == "-" を欠落させる
length(answer)
length(lost)
print(lost, n = 5)
dplyr::anti_join(attribute, lost) # attributeにあって，lostにないもの

  # 列の選択
  # 02_19_analysis-dplyr-select.R
dplyr::select(answer, id, area, period) |> head(3)
dplyr::select(sales, -c(period, item)) |> head(3)

  # 行を抽出
  # 02_20_analysis-dplyr-filter.R
dplyr::filter(answer, satisfy == "5") |> head(3)
dplyr::filter(sales, 600 < price & price < 700) |> head(3)

  # 重複の除去
  # 02_21_analysis-dplyr-distinct.R
dplyr::distinct(answer, area)
dplyr::distinct(sales, period, sheet) |> 
  print(n = 3)

  # 並べ替え
  # 02_22_analysis-dplyr-arrange.R
dplyr::arrange(answer, period) |> head(3)
dplyr::arrange(sales, desc(count)) |> head(3)

  # 列の順序変更
  # 02_23_analysis-dplyr-relocate.R
dplyr::relocate(answer, apps) |> head(3)
dplyr::relocate(answer, comment, .before = apps) |> head(3)

  # 列名の変更
  # 02_24_analysis-dplyr-rename.R
sales <- dplyr::rename(sales, shop = sheet)
head(sales, 3)

  # 列の追加
  # 02_25_analysis-dplyr-mutate.R
dplyr::mutate(answer, id = as.numeric(id), period = as.numeric(period))
answer |>
  dplyr::mutate(ap = stringr::str_sub(apps, 1, 2), .before = 2) |> # 2列目の前
  dplyr::mutate(co = stringr::str_sub(comment, 1, 2), .after = ap)

  # 列の追加
  # 02_26_analysis-dplyr-mutate-new-col.R
sales <- dplyr::mutate(sales, amount = count * price)
head(sales, 3)

  # 指定列の追加
  # 02_27_analysis-dplyr-mutate-at.R
answer <- dplyr::mutate_at(answer, c("id", "period", "satisfy"), as.numeric)

  # 指定列の追加
  # 02_28_analysis-dplyr-mutate-if.R
dplyr::mutate_if(answer, is.numeric, magrittr::multiply_by, 100) |> head(3)

  # 列の追加と選択
  # 02_29_analysis-dplyr-transmute.R
dplyr::transmute(sales, item = stringr::str_sub(item, 1, 2), count) |> head(5)

  # グループ化
  # 02_30_analysis-dplyr-group-by.R
dplyr::group_by(answer, area) |> print(n = 3)
dplyr::group_by(sales, item) |> print(n = 3)

  # 平均や最大値などの集計
  # 02_31_analysis-dplyr-summarise.R
dplyr::group_by(answer, area) |> 
  dplyr::summarise(m_period = mean(period), m_satisfy = mean(satisfy))

  # .byを使った平均や最大値などの集計
  # 02_32_analysis-dplyr-summarise-by.R
dplyr::summarise(answer,m_period = mean(period), m_satisfy = mean(satisfy), 
                 .by = area)

  # 数値の列の集計
  # 02_33_analysis-dplyr-summarise-if.R
dplyr::group_by(sales, item) |> 
  dplyr::summarise_if(is.numeric, max)

  # 個数を数える
  # 02_34_analysis-dplyr-n.R
dplyr::group_by(answer, area) |> 
  dplyr::summarise(n = n())

  # 個数を数えるショートカット
  # 02_35_analysis-dplyr-tally.R
dplyr::group_by(answer, area) |> 
  dplyr::tally() |> head(3)
dplyr::count(answer, area) |> head(3)
dplyr::count(sales, shop, wt = count) |> head(3)

  # 集計後の表示変更
  # 02_36_analysis-dplyr-summarise-pivot-wider.R
sales |>
  dplyr::summarise(sum = round(sum(amount) / 1000), .by = c(period, shop)) |>
  tidyr::pivot_wider(names_from = shop, values_from = sum)

  # 複数回答を集計する関数
  # 02_37_analysis-dplyr-count-multi-ans-fun.R
count_multi <- function(df, col, sep = "[^[:alnum:]]+", group_add = TRUE){
  df |>
    tidyr::separate_rows(tidyselect::all_of(col), sep = sep) |>  # 縦に分割
    dplyr::filter({{ col }} != "") |>                            # 空を除去
    dplyr::filter(!is.na({{ col }})) |>                          # NAを除去
    dplyr::group_by(dplyr::pick({{ col }}), .add = group_add) |> # グループ化
    dplyr::tally() |>                                            # 個数
    dplyr::filter({{ col }} != "")                               # 空を除去
}

  # 単純集計
  # 02_38_analysis-dplyr-straight-summary.R
dplyr::count(answer, area) # 単数回答・単純集計
count_multi(answer, "apps") # 複数回答・単純集計

  # クロス集計
  # 02_39_analysis-dplyr-cross-summary.R
dplyr::count(answer, area, satisfy) |> # 単数回答・クロス集計
  tidyr::pivot_wider(names_from = area, values_from = n, values_fill = 0)
answer |> # 複数回答・クロス集計
  dplyr::group_by(area) |>
  count_multi("apps", sep = ";") |>
  tidyr::pivot_wider(names_from = area, values_from = n, values_fill = 0)

  # 基本的な描画(箱ひげ図)
  # 02_40_analysis-ggplot-ggplot.R
sales |>
  ggplot2::ggplot(ggplot2::aes(x = item, y = count)) + 
  ggplot2::geom_boxplot()

  # ジッター・プロット
  # 02_41_analysis-ggplot-geom-jitter.R
sales |>
  ggplot2::ggplot(ggplot2::aes(item, count)) + 
  ggplot2::geom_jitter()

  # 箱ひげ図とジッター・プロットの重ね合わせ
  # 02_42_analysis-ggplot-geom-boxplot-geom-jitter.R
gg_sales <- 
  sales |>
  ggplot2::ggplot(ggplot2::aes(item, count)) + 
  ggplot2::geom_boxplot(outlier.color = NA) + # 外れ値の重複を防止
  ggplot2::geom_jitter(width = 0.3, height = 0, size = 0.3) +
  ggplot2::guides(x = ggplot2::guide_axis(n.dodge = 2)) # x軸の重なり防止
gg_sales

  # テーマの変更
  # 02_43_analysis-ggplot-theme.R
gg_sales + ggplot2::theme_bw()

  # forとsubset()を使った散布図の分割
  # 02_44_analysis-ggplot-facet-for.R
par(mfcol = c(3, 3))
par(mar = rep(0.1, 4))
par(oma = rep(0.1, 4))
for(s in unique(sales$shop)){
  sales_sub <- subset(sales, shop == s)
  plot(factor(sales_sub$item), sales_sub$count)
}

  # facetによる分割して作図
  # 02_45_analysis-ggplot-facet-wrap.R
sales |>
  ggplot2::ggplot(ggplot2::aes(item, count)) + 
    ggplot2::geom_boxplot() + 
    ggplot2::facet_wrap(vars(shop))

  # テーマの変更とファセットの追加
  # 02_46_analysis-ggplot-facet-wrap-theme.R
gg_sales + 
  ggplot2::theme_bw() + 
  ggplot2::facet_wrap(vars(shop))

  # 作図のファイルへの保存
  # 02_47_analysis-ggplot-ggsave.R
path <- fs::file_temp(ext = "png")
ggplot2::ggsave(path, gg_sales)

  # extrafontとCairoのインストールと呼び出し
  # 02_48_analysis-extrafont.R
install.packages("extrafont")
install.packages("Cairo")
library(extrafont)
library(Cairo)

  # フォントのインポート
  # 02_49_analysis-extrafont-font-import.R
extrafont::font_import()

  # フォントの登録
  # 02_50_analysis-extrafont-loadfonts.R
extrafont::loadfonts()

  # 利用可能なフォントの確認
  # 02_51_analysis-extrafont-font.R
extrafont::fonts()
extrafont::fonts() |>
  stringr::str_subset("Yu")

  # PDFファイルの文字化け対策
  # 02_52_analysis-ggplot-notofu.R
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
  # 02_53_analysis-geom-text.R
tibble::tibble(x = 1:5, y = 1:5, label = c("あ", "い", "う", "え", "お")) |>
  ggplot2::ggplot(aes(x, y, label = label)) +
  ggplot2::geom_text(family = "Yu Mincho", size = 10)
path <- fs::file_temp(ext = "pdf")
ggplot2::ggsave(path, device = cairo_pdf)
  # shell.exec(path)

  # データフレームのリストへの分割
  # 02_54_analysis-purrr-split-area.R
split(answer, answer$area)

  # リストに分割する関数の定義
  # 02_55_analysis-purrr-split-by-fun.R
split_by <- function(df, group){
  split(df, df[[group]])
}

  # 集計の繰り返し
  # 02_56_analysis-purrr-answer.R
answer |>
  split_by("area") |>
  purrr::map(count_multi, "apps", ";") |>
  purrr::map(dplyr::arrange, desc(n))

  # 作図の繰り返し
  # 02_57_analysis-purrr-split-imap.R
gg_sales_split <- 
  sales |>
  split_by("shop") |>
  purrr::imap(
    \(.x, .y){
      ggplot2::ggplot(.x, ggplot2::aes(period, count, group = item)) +
      ggplot2::geom_line(aes(color = item)) +
      ggplot2::theme_bw() + 
      ggplot2::theme(text = ggplot2::element_text(family = "Yu Mincho")) + 
      ggplot2::labs(title = .y)
    }
  )
gg_sales_split[[2]] # 2番目のグラフ

  # 複数の図の保存
  # 02_58_analysis-purrr-split-map2.R
pdfs <- 
  paste0(names(gg_sales_split), ".pdf") |>
  fs::path_temp()
purrr::map2(pdfs, gg_sales_split, ggsave, 
            device = cairo_pdf, width = 7, height = 7)
  # shell.exec(pdfs[1])

  # 2のときにエラーになる関数
  # 02_59_analysis-purrr-safely-prep.R
error_if_two <- function(x){
  if(x == 2){
    stop("エラーです")
  }else{
    return(x)
  }
}

  # 繰り返し処理のエラー対応
  # 02_60_analysis-purrr-safely.R
purrr::map(1:3, error_if_two)  # そのままのとき
error_if_two_possibly <- possibly(error_if_two, otherwise = 0) # エラー時は0
purrr::map_dbl(1:3, error_if_two_possibly)

  # 順次処理の関数の基本動作
  # 02_61_analysis-purrr-reduce-add.R
accumulate(1:4, `*`)
reduce(1:4, `*`)

  # 新しいものを追加する関数
  # 02_62_analysis-purrr-paste-if-new-fun.R
paste_if_new <- function(x, y){
  pattern <- paste0("(^|;)+", y, "(;|$)+")
  if(stringr::str_detect(x, pattern)){
    x
  }else{
    paste0(x, ";", y)
  }
}

  # 順次処理の関数
  # 02_63_analysis-purrr-reduce.R
answer |> 
  dplyr::summarise(apps = reduce(apps, paste_if_new), 
                   .by = c(area, satisfy))

