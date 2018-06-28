pollutantmean = function (directory, pollutant, id = 1:332) {
  if (pollutant != 'sulfate' && pollutant != 'nitrate') {
    return ('error, please type "sulfate" or "nitrate"')
  }
  dat = data.frame()
  for (i in id) {
    dir = paste(directory,'/', string(i), '.csv', sep = '')
    df = read.csv(dir)
    dat = rbind(dat, df)
  }
  result = mean(dat[, pollutant], na.rm = TRUE)
  return (result)