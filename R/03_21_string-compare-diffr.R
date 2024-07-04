  # 文章の比較
  # 03_21_string-compare-diffr.R
f1 <- fs::file_temp()
f2 <- fs::file_temp()
writeLines("日本語での比較実験\n今日は晴れです．\n同じ文章", con = f1)
writeLines("英語での比較の実験\n今日は天気です．\n同じ文章", con = f2)
diffr::diffr(f1, f2, before = fs::path_file(f1), after = fs::path_file(f1))

