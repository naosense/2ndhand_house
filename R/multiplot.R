# 将多个图形打印到一起。
#
# @param m 行数
# @param n 列数
# @param plist 图片引用字符组成的vector，例如要打印a和b图形，则plist为c("a", "b")
# @param filename width height 分别为图片的文件名、宽度和高度
require(grid)


multiplot <- function(m, n, plist, filename = "sub%03d.png", 
                     width = 460, height = 300, ...) {
    if (length(plist) != m * n) stop("图片数量不正确!")
    png(filename = filename, width = width, height = height, ...)
    grid.newpage()
    ps <- unique(plist)
    pushViewport(viewport(layout = grid.layout(m, n)))
    
    for (i in seq_along(ps)) {
        xy <- which(plist == ps[i])
        l <- length(xy)
        if (l == 1) {
            x <- ceiling(xy / n)
            y <- xy %% n
            if (y == 0) y <- n
            print(eval(parse(text = ps[i])), vp = vplayout(x, y))
        } else {
            minxy <- min(xy)
            maxxy <- max(xy)
            
            xmin <- ceiling(minxy / n) 
            ymin <- min(xy) %% n
            if (ymin == 0) ymin <- n
            xmax <- ceiling(maxxy / n)
            ymax <- max(xy) %% n
            if (ymax == 0) ymax <- n
            
            print(eval(parse(text = ps[i])), vp = vplayout(xmin:xmax, ymin:ymax))
            
        }
    }
    dev.off()
}

vplayout <- function(x, y)
    viewport(layout.pos.row = x, layout.pos.col = y) 
