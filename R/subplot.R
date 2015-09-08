# 将两张fig以主副图的形式打印成png图片
#
# Args:
#   main: 主图引用
#   sub: 副图引用
#   ...: png函数的参数
#   wh: 副图的宽高
#   corner: 代表副图位置的字符串
#   offset: 副图中心的偏移量
#
# Returns：
#   一张png图片
#
# Examples:
#   a <- qplot(...)
#   b <- qplot(...)
#   subplot(a, b, filename = "test.png")
require(grid)


subplot <- function(main, sub, ..., wh = c(0.4, 0.4), corner = "RB", offset = c(0, 0)) {
    png(...)
    if (corner == "RB") 
        subvp <- viewport(width = wh[1], height = wh[2], x = 1 - wh[1] / 2 + offset[1], y = wh[2] / 2 + offset[2])
    else if (corner == "LB")
        subvp <- viewport(width = wh[1], height = wh[2], x = wh[1] / 2 + offset[1], y = wh[2] / 2 + offset[2])
    else if (corner == "LT")
        subvp <- viewport(width = wh[1], height = wh[2], x = wh[1] / 2 + offset[1], y = 1- wh[2] / 2 + offset[2])
    else if (corner == "RT")
        subvp <- viewport(width = wh[1], height = wh[2], x = 1- wh[1] / 2 + offset[1], y = 1- wh[2] / 2 + offset[2])
    else
        stop("请设置附图的方位！")
    
    mainvp <- viewport(width = 1, height = 1)
    print(main, vp = mainvp)
    print(sub, vp = subvp)
    dev.off()
}