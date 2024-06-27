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

