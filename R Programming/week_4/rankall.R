rankall = function(outcome, num = "best") {
  data = read.csv("../../dataset/hospital/outcome-of-care-measures.csv", colClasses = "character")
  disease_list = c("heart attack", "heart failure", "pneumonia")
  Statelist = as.character(unique(data$State))
  
  if (!(outcome %in% disease_list)) {
    print("invalid disease")
    return(NA)
  }
  
  if (outcome == "heart attack") { 
    data = data[c("Hospital.Name", "State", "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack")]
  }
  else if (outcome == "heart failure"){
    data = data[c("Hospital.Name", "State", "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure")]
  }
  else {
    data = data[c("Hospital.Name", "State", "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")]
  }
  
  colnames(data)[3] = "Disease.Rate"
  data[, "Disease.Rate"] = as.numeric(as.character(data[, "Disease.Rate"]))
  data[, "Hospital.Name"] = as.character(data[, "Hospital.Name"])
  
  result_data = data.frame()
  for (i in seq_len(length(Statelist))){
    StateData = subset(data, State == Statelist[i])
    StateData = StateData[order(StateData$Disease.Rate, StateData$Hospital.Name), ]
    StateData = na.omit(StateData)
    hospital_name = NA
    if (num == "best"){
      num = 1
    }
    if (num == "worst"){
      N = sum(!is.na(StateData$Disease.Rate))
      num = N
    }
    if (num > length(StateData$Hospital) | num <= 0) {
      next
    }
    hospital_name = StateData$Hospital.Name[num]
    tmp = data.frame(hospital_name, Statelist[i])
    colnames(tmp) = c("hospital", "state") 
    result_data = rbind(result_data, tmp)
  }
  return (result_data)
}