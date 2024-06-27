  # RDCOMClientのインストール
  # 10_29_RDCOMClient-install.R
  # zipファイルでのインストール
install.packages("RDCOMClient", 
                 repos = "http://www.omegahat.net/R", type = "win.binary")

  # ソースファイルからビルドしてインストール
  # install.packages("remotes") # remotesをインストールしていないとき
  # Rtoolsも必要
remotes::install_github("omegahat/RDCOMClient")

