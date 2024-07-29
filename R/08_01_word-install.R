  # officerとRDCOMClientのインストールと呼び出し
  # 08_01_word-install.R
install.packages("officer")
  # zipファイルでのインストール
install.packages("RDCOMClient", 
                 repos = "http://www.omegahat.net/R", type = "win.binary")
  # ソースファイルからビルドしてインストール(Rtoolsが必要)
  # install.packages("remotes") # remotesをインストールしていないとき
remotes::install_github("omegahat/RDCOMClient")
  # 呼び出し
library("officer")
library("RDCOMClient")

