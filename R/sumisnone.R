# 验证数据框的每一列是否有空值或NA
require(plyr)

isnone <- function(cl) {
    sum(cl == "" || is.na(cl))
}
sumisnone <- colwise(isnone)