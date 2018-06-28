best = function(state, outcome) {
  data = read.csv("../../dataset/hospital/outcome-of-care-measures.csv", colClasses = "character")
  disease_list = c("heart attack", "heart failure", "pneumonia")
  if (state %in% data$State & outcome %in% disease_list) {
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
    result = StateData$Hospital.Name[1]
    return (result)
  }
  return (NULL)
}
