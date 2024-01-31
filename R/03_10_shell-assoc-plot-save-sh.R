  # シェルスクリプトの保存
  # 03_10_shell-assoc-plot-save-sh.R
code <- 
"#! /bin/bash
/usr/local/bin/Rscript ~/plot.R"
path_sh <- fs::path(fs::path_home(), "plot.sh")
write(code, path_sh)
  # shell_open(path_sh) # Rコードを開く

