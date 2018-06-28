rankhospital = function(state, outcome, num) {
  data = read.csv("../../dataset/hospital/outcome-of-care-measures.csv", colClasses = "character")
  disease_list = c("heart attack", "heart failure", "pneumonia")
  if (!(state %in% data$State)) {
    print("invalid state")
    return(NA)
  }
  if (!(outcome %in% disease_list)) {
    print("invalid disease")
    return(NA)
  }
  StateData = subset(data, State == state)
  if (outcome == "heart attack") { 
    StateData = StateData[c("Hospital.Name","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack")]
  }
  else if (outcome == "heart failure"){
    StateData = StateData[c("Hospital.Name","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure")]
  }
  else {
    StateData = StateData[c("Hospital.Name", "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")]
  }
  colnames(StateData) = c("Hospital.Name", "Disease.Rate")
  StateData[, "Disease.Rate"] = as.numeric(as.character(StateData[, "Disease.Rate"]))
  StateData[, "Hospital.Name"] = as.character(StateData[, "Hospital.Name"])
  StateData = StateData[order(StateData$Disease.Rate, StateData$Hospital.Name), ]
  StateData = na.omit(StateData)
  if (num == "best") {
    result = StateData$Hospital.Name[1]
  }
  if (num == "worst") {
    N = sum(!is.na(StateData$Disease.Rate))
    result = StateData$Hospital.Name[N]
  }
  else if (num > length(StateData$Hospital) | num <= 0) {
    print("invalid num")
    return(NA)
  }
  else {
    result = StateData$Hospital.Name[num]
  }
  return (result)
}