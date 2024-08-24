  # ユーザからの入力関連の関数
  # 07_07_pdf-user-input.R
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

  # ユーザ入力のページ数を数値に変換する関数
input_numbers <- function(prompt, choices = ""){
  inputs <- user_input(prompt, choices)
  pages <- eval_strings(inputs)
  return(pages)
}

  # ファイルの一覧を選択肢として返す関数
gen_choices <- function(files){
  no <- seq(files)
  stringr::str_c("  ", no, ": ", files, "\n", collapse = "")
}

