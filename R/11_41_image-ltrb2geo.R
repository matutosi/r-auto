  # ```{r image-ltrb2geo, eval = FALSE, subject = 'ltrb2geo()', caption = '左上・右下の位置のでの切り取り'}
  # 11_41_image-ltrb2geo.R
geometry <- ltrb2geo(c(400, 450), c(1000, 950))
geometry
croped_ltrb <- image_crop(imgs[25], geometry = geometry)
plot(croped_ltrb)

