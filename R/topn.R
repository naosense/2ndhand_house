# 从数据框选出给定条件的前n行
#
# Args:
#   df: 数据框
#   index: 排序依据的列名
#   n: 为要选择的行数
#   dec: 是否降序
#   na.rm: 是否移除NA值
#
# Returns:
#   符合条件的前n行
topn <- function(df, index, n, dec = FALSE, na.rm = TRUE) {
    index <- as.character(substitute(index))
    d <- df[order(df[[index]], decreasing = dec), ]
    d <- d[1:n, ]
    
    if (na.rm) na.omit(d)
    
}
