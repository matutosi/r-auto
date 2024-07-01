  # ggplotのグラフを追加
  # 10_17_powerpoint-ggplot.R
  # install.packages("rvg")
gg_iris <- # ggplotオブジェクト
  iris |> 
  ggplot2::ggplot(ggplot2::aes(Sepal.Length, Petal.Length, color = Species)) +
  ggplot2::geom_point(size = 3) + 
  ggplot2::theme_minimal()
  # スライドの最大サイズで追加
pp <- add_slide(pp) 
pp <- ph_with(pp, "最大サイズでのggplotの追加",
              location = ph_location_type(type = "title"))
pp <- ph_with(pp, gg_iris, location = ph_location_fullsize())
  # 指定位置の大きさで追加
pp <- add_slide(pp)
pp <- ph_with(pp, "Placeholder 2への追加", 
              location = ph_location_type(type = "title"))
pp <- ph_with(pp, gg_iris, 
              location = ph_location_label("Content Placeholder 2"))
  # 編集可能な図として追加
editable_gg <- rvg::dml(ggobj = gg_iris)
pp <- add_slide(pp)
pp <- ph_with(pp, "編集可能な図として追加", 
              location = ph_location_type(type = "title"))
pp <- ph_with(pp, editable_gg,
              location = ph_location_label("Content Placeholder 2"))
  # パワーポイントの保存
print(pp, target = path)
  # shell.exec(path)

