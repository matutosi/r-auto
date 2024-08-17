  # カレンダーでの確認
  # 06_34_date-gen-cal.R
weeknames <-  c("M", "T", "W", "T", "F", "S", "S")
title_1 <- paste0(year(x)    , "-" , month(x))
title_2 <- paste0(year(x) + 1, "-" , month(x))
  # カレンダーでの表示
calendR::calendR(year(x)    , month(x),
  title = title_1, start = "M", weeknames = weeknames, papersize = "A6")
calendR::calendR(year(x) + 1, month(x),
  title = title_2, start = "M", weeknames = weeknames, papersize = "A6")

