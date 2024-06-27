  # 個別メールの作成
  # 12_19_mail-gen-gmail-fun.R
gen_gmail <- function(to, from, subject, body, cc, bcc){
  gmail <- 
    gmailr::gm_mime(to = to, cc = cc, bcc = bcc,
                    subject = subject, body = body)
  return(gmail)
}

