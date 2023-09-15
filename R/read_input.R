
expand_output = function(x) {
if(x == "s") out = "suspicious"
if(x == "d") out = "does occur"
if(x == "n") out = "does not occur"
return(out)
}

read_input = function() {
  selection = "BAD"
  while(!selection=="GOOD") {
    cat("Enter Annotation : \n")
    cat("🔍 S) suspicious \n")
    cat("🧊 D) does occur \n")
    cat("⛔️ N) does not occur \n")
    choice = readline(prompt="Enter a choice: ")
    if(!tolower(choice) %in% c("s","d","n")) {
      cat("not a good selection, try again")
      selection = "BAD"
    } else {
      selection = "GOOD"
    }
}
return(expand_output(choice))
}



