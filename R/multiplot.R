# 将多个图形打印成一个png图片。
#
# Args:
#   m: 行数
#   n: 列数
#   pic: 图片引用字符组成的vector，例如要打印a和b图形，则pic为c("a", "b")
#   filename: 图片文件名
#   width: 图片宽度
#   height: 图片高度
#
# Returns:
#   一个png图片
# 
# Examples:
#   a <- qplot(...)
#   b <- qplot(...)
#   c <- qplot(...)
#   # 下面的代码将会把一个图片以2*2分割，然后a图片将会占据第一行两列，
#   # b将会占据第二行第一列，c将会占据第二行第二列。
#   multiplot(2, 2, c("a", "a", "b", "c"))
require(grid)


multiplot <- function(m, n, pic, filename = "sub%03d.png", 
                     width = 460, height = 300, ...) {
    if (length(pic) != m * n) stop("图片数量不正确!")
    png(filename = filename, width = width, height = height, ...)
    grid.newpage()
    ps <- unique(pic)
    pushViewport(viewport(layout = grid.layout(m, n)))
    
    for (i in seq_along(ps)) {
        xy <- which(pic == ps[i])
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
