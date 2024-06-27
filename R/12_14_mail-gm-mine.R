  # メールの作成の別の方法
  # 12_14_mail-gm-mine.R
gmail <-
  gm_mime(to = "hogehoge@gmail.com",
          subject = "テストメール1",
          body = "テストメールの本文．", 
          attach_file = "photo.jpg")

