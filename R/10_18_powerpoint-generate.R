  # パワーポイントの作成
  # 10_18_powerpoint-generate.R
str <- c("-大項目;--中項目;-大項目;--中項目;--中項目;---小項目;---小項目")
ft <- flextable::flextable(head(iris)) |> flextable::autofit()
gg_iris <- ggplot2::ggplot(iris, 
  ggplot2::aes(Sepal.Length, Petal.Length, color = Species)) +
  ggplot2::geom_point(size = 3) + ggplot2::theme_minimal()
  # install.packages("rvg")
editable_gg <- rvg::dml(ggobj = gg_iris)
r_img <- fs::path_temp("r.png")
curl::curl_download("https://matutosi.github.io/r-auto/data/r_gg.png", r_img)

pp <- 
  read_pptx() |>
  add_content(title = "箇条書き", content = str2ul(str)) |>
  add_content(title = "irisデータ", content = head(iris)) |>
  add_content(title = "iris(flextable)", content = ft) |>
  add_content(title = "ggplotの図", content = gg_iris) |>
  add_content(title = "編集可能な図", content = editable_gg) |>
  add_fig(title = "pngなどの画像", path_img = r_img)

path <- fs::path_temp("slide.pptx")
print(pp, target = path)
  # shell.exec(path)

