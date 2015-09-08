stat_sum_single <- function(fun, geom="point", size = 1, ...) {
    stat_summary(fun.y=fun, geom=geom, size = size, ...)
}