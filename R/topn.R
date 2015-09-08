# 从数据框选出给定条件的前n行
#
# @param df, index, n 分别为数据框，排序依据的列名，n为要选择的行数。
# dec和na.rm分别为是否降序，是否移除NA值
topn <- function(df, index, n, dec = FALSE, na.rm = TRUE) {
    index <- as.character(substitute(index))
    d <- df[order(df[[index]], decreasing = dec), ]
    d <- d[1:n, ]
    
    if (na.rm) na.omit(d)
    
}
