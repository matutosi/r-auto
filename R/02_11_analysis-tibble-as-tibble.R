  # データフレームのへのtibbleの変換
  # 02_11_analysis-tibble-as-tibble.R
data(iris)
class(iris)
iris # 全部表示される
iris_tibble <- tibble::as_tibble(iris)
class(iris_tibble)
iris_tibble # 最初の部分が表示される

