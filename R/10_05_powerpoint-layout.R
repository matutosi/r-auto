  # レイアウトの確認
  # 10_05_powerpoint-layout.R
pp <- read_pptx()
layout_name <-                                    # レイアウト名
  layout_properties(pp)$name |>
  unique()
for(ln in layout_name){                           # レイアウトごとに
  pp <- add_slide(pp, layout = ln)                # スライドを追加
  ph_label <-                                     # プレイスホルダーの一覧
    layout_properties(pp, layout = ln)$ph_label |>
    unique()
  for(pl in ph_label){                            # プレイスホルダーごとに
    val <- pl                                     # プレイスホルダーのラベル
    if(stringr::str_detect(pl, "Title|タイトル")){
      val <- paste0(val, ": ", ln)
    }
    loc <- ph_location_label(ph_label = pl)
    pp <- ph_with(pp, value = val, location = loc) # プレイスホルダーを追加
  }
  if(ln == "Blank"){
    pp <- ph_with(pp, value = ln, location = ph_location())
  }
}
path <- fs::path_temp("layout.pptx")
print(pp, target = path)
  # shell.exec(path)

