corr = function (directory, threshold = 0) {
  files = list.files(directory, full.names = TRUE)
  dat = vector(mode = 'numeric', length = 0)
  for (i in 1:length(files)) {
    df = read.csv(files[i])
    csum = sum((!is.na(df$sulfate)) & (!is.na(df$nitrate)))
    if (csum > threshold) {
      temp = df[which(!is.na(df$sulfate)), ]
      sub_df = temp[which(!is.na(temp$nitrate)), ]
      dat = c(dat, cor(sub_df$sulfate, sub_df$nitrate))
    }
  }
  return (dat)
}