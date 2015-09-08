# 主副图绘制函数
#
# @param main 主图引用
# @param sub 副图引用
# @param wh 副图的宽高
# @param corner 代表副图位置的字符串
# @param offset 副图中心的偏移量
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