  # TexTraによる翻訳
  # 13_19_translate-textrar.R
models <- c("transLM", "patentNT", "seikatsu")
text <- split_sentence(text)
len <- length(text)
translated_models <- list()
for(model in models){
  for(i in 1:len){
    translated_models[[model]][i] <- textra(text[i], params, model = model)
  }
}
result2 <- tibble::as_tibble(translated_models)
result <- dplyr::bind_cols(result, result2) |>
  print()

