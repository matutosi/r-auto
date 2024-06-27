  # TexTraによる翻訳
  # 13_21_translate-textrar.R
text <- split_sentence(text)
tr_gener <- list()
tr_paten <- list()
tr_seika <- list()
len <- length(text)
for(i in 1:len){
  tr_gener[i] <- textra(text[i], params)
  tr_paten[i] <- textra(text[i], params, model = "patentNT")
  tr_seika[i] <- textra(text[i], params, model = "seikatsu")
}
tr_gener <- unlist(tr_gener)
tr_paten <- unlist(tr_paten)
tr_seika <- unlist(tr_seika)
result2 <- tibble::tibble(gener = tr_gener, paten = tr_paten, seika = tr_seika)
result <- dplyr::bind_cols(result, result2) |>
  print()

