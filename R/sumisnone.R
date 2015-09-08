require(plyr)

isnone <- function(cl) {
    sum(cl == "" || is.na(cl))
}
sumisnone <- colwise(isnone)