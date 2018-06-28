complete = function (directory, id = 1:332) {
  dat = data.frame()
  for (i in id) {
    dir = paste(directory,'/', string(i), '.csv', sep = '')
    df = read.csv(dir)
    nob = sum(complete.cases(df))
    temp = data.frame(paste(string(i), '.csv', sep = ''), nob)
    dat = rbind(dat, temp)
  }
  colnames(dat) = c('id', 'nobs')
  return (dat)
}