# convert farenheit to kelvin

far_to_kel <- function(temp){
  kelvin <- ((temp - 32)*(5/9)) + 273.15 #temp = argument, what you're inputting
  return(kelvin)   #optional in R (automatically returns final output) but declares last value
}

far_to_kel(0)
far_to_kel(32)

far_to_kel_2 <- function(temp){
  stopifnot("temp must be numeric")
  kelvin <- ((temp - 32)*(5/9)) + 273.15 #temp = argument, what you're inputting
  return(kelvin)   #optional in R (automatically returns final output) but declares last value
}

# convert kelvin to celsius
kel_to_cel <- function(temp){
  cel <- (temp - 273.15)
  return(cel)
}

kel_to_cel(0)

# write a function converting Fahrenheight to Celsius 
# by reusing the two functions you just wrote

far_to_cel <- function(far){
  cel <- kel_to_cel(far_to_kel(far))
  return(cel)
}

far_to_cel(32)
far_to_cel(212)

# option 2
far_to_cel_2 <- function(temp){
  kel <- far_to_kel(temp)
  cel <- kel_to_cel(kel)
  return(cel)
}

far_to_cel_2(32)
far_to_cel_2(212)

# use stopifnot to convert Fahrenheit to celsius.
far_to_cel_3 <- function(temp){
  if(!is.numeric(temp)) {
    stop("not numeric")
  }
  kel <- far_to_kel(temp)
  cel <- kel_to_cel(kel)
  return(cel)
}

far_to_cel_3("10")
far_to_cel_3(32)
