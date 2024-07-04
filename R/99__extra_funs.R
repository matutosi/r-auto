  # 文字列を数値として返す関数
user_input <- function(prompt = "", choices = ""){
  prompt <- stringr::str_c(prompt, choices)
  if(interactive()){          # 双方向式のとき
    input <- readline(prompt) # 入力受付
    return(input)
  } else {                    # 双方向でないとき(スクリプトなど)
    cat(prompt)
    input <- readLines("stdin", n = 1) # 入力受付
    return(input)
  }
}
  # 実行例
  # user_input("何か入力してください\n")
  # 1       # 1と入力すると
  # [1] "1" # 文字列としての"1"が返り値になる 

  # 文字列を数値として返す関数
eval_strings <- function(x){
  x |>
    stringr::str_replace_all("-", ":") |> # 「-」を「:」に変換
    stringr::str_split_1(",") |> # 「,」で分割
    str2expression() |>          # 文字列を式に
    as.list() |>                 # mapを使うためリストに
    purrr::map(eval) |>          # 評価
    unlist()                     # ベクトルに
}
  # 実行例
  # eval_strings("1,5-9,21:25")
  # [1]  1  5  6  7  8  9 21 22 23 24 25

  # ユーザ入力のページ数を数値に変換する関数
input_numbers <- function(prompt, choices = ""){
  inputs <- user_input(prompt, choices)
  pages <- eval_strings(inputs)
  return(pages)
}
  # 実行例
  # input_numbers("数字を入力してください\n")
  # 数字を入力してください
  # 1:3,6,7-10
  # [1]  1  2  3  6  7  8  9 10

  # ファイルの一覧を選択肢として返す関数
gen_choices <- function(files){
  no <- seq(files)
  stringr::str_c("  ", no, ": ", files, "\n", collapse = "")
}
  # 実行例
  # paste0(letters[1:3], ".pdf") |>
  #   gen_choices() |>
  #   cat()
