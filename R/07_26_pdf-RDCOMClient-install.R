  # RDCOMClientのインストールと呼び出し
  # 07_26_pdf-RDCOMClient-install.R
  # zipファイルでのインストール
install.packages("RDCOMClient", 
                 repos = "http://www.omegahat.net/R", type = "win.binary")
  # ソースファイルからビルドしてインストール(Rtoolsが必要)
  # install.packages("remotes") # remotesをインストールしていないとき
remotes::install_github("omegahat/RDCOMClient")
library("RDCOMClient")

