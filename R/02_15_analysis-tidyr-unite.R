  # 列の統合
  # 02_15_analysis-tidyr-unite.R
tidyr::unite(sales, col = "shop_item", sheet, item, sep = "-") |> head(3)
tidyr::unite(sales, "shop_item", sheet, item, remove = FALSE) |> head(3)

