  # 指定したディレクトリへのファイルの移動
  # 01_21_file-move.R
files <- c("hoge.txt", "fuga.txt", "piyo.txt")
files
result <- file_move(files, new_path = "abc")
result
  # abc/hoge.txt abc/fuga.txt abc/piyo.txt

