  # 文字列の入った表の作成
  # 09_20_excel-pivot-pivotea.R
url <- "https://matutosi.github.io/r-auto/data/timetable.csv"
csv <- fs::path_temp("timetable.csv")
curl::curl_download(url, csv) # urlからPDFをダウンロード
syllabus <- 
  readr::read_csv(csv, show_col_types = FALSE) |>
  dplyr::mutate(subj = paste0(stringr::str_sub(subject, 1, 2),
                              stringr::str_sub(subject, -2, -1))) |>
  dplyr::mutate(wday = stringr::str_replace(wday, "月", "1月")) |>
  dplyr::mutate(wday = stringr::str_replace(wday, "火", "2火")) |>
  dplyr::mutate(wday = stringr::str_replace(wday, "水", "3水")) |>
  dplyr::mutate(wday = stringr::str_replace(wday, "木", "4木")) |>
  dplyr::mutate(wday = stringr::str_replace(wday, "金", "5金"))
timetable <- 
  syllabus |>
  pivotea::pivot(row = c("grade", "hour"), col = "wday", 
  val = c("subj", "teacher"), split = "semester")
head(timetable[[1]])
file_timetable <- fs::path_temp("timetable.xlsx")
write.xlsx(timetable, file_timetable) # シート別に書き込み
  # shell.exec(file_timetable)

