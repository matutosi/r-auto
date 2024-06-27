  # メールの作成
  # 12_12_mail-gm-email.R
gmail <-
  gm_mime() |>
  gm_to("hogehoge@gmail.com") |>
  gm_subject("テストメール1") |>
  gm_text_body("テストメールの本文．") |>
  gm_attach_file("photo.jpg") # 作業ディレクトリにphoto.jpgがある場合

