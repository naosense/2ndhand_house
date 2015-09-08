loaddata <- function() {
    
    hcolname <- c("area", "region", "zone", "meters", "direction", "con", "floor", "year", "school", "subway", "tax", "num", "price")
    houses <- read.csv("houses_30000.txt", header=FALSE, col.names=hcolname, stringsAsFactors=FALSE)
    
    # 将区域英文代码替换为中文
    area_en <- c("BJCP", "BJCY", "BJDC", "BJDX", "BJFS", "BJFT", "BJHD", "BJMT", "BJMY", "BJSJ", "BJSY", "BJTJ", "BJXC", "BJYZ", "LFYJ")
    area_zh <- c("昌平", "朝阳", "东城", "大兴", "房山", "丰台", "海淀", "门头沟", "密云", "石景山", "顺义", "通州", "西城", "亦庄", "燕郊")
    houses <- within(houses, {
        area <- factor(area, levels = area_en, labels = area_zh)
        region <- factor(region)
        zone <- factor(zone, order = T)
        direction <- factor(direction)
        con <- factor(con)
        
        floor[floor %in% c("第1层", "第2层","第3层")] <- "低楼层"
        floor[floor %in% c("第4层", "第5层","第6层", "第7层", "第8层", "第9层")] <- "中楼层"
        floor[floor %in% c("第10", "第13","第14", "第15", "第16", "第17", "第18")] <- "高楼层"
        floor <- factor(floor, order = T, levels = c("地下室", "低楼层", "中楼层", "高楼层"))
        
        school <- factor(school, order = T, levels = c(0, 1), labels = c("无学区", "有学区"))
        subway <- factor(subway, order = T, levels = c(0, 1), labels = c("无地铁", "有地铁"))
        
        tax[tax == ""] <- "非免税"
        tax <- factor(tax, levels = c("非免税", "满五年唯一"))
    })
    
}

houses <- loaddata()
# 数据整理
houses <- na.omit(houses)
houses <- subset(houses, price != 63043479 & num != 1 & year > 1950)

# 增加四列，对面积，年代，总价，单价进行区间划分
houses$meters_cg <- cut(houses$meters, breaks = c(0, 50, 100, 150, 200, Inf),
                        labels = c("0~50", "50~100", "100~150", "150~200", ">200"),
                        ordered_result = T)
houses$year_cg <- cut(houses$year, breaks = c(0, 1990, 1995, 2000, 2005, 2010, 2015, Inf),
                      labels = c("<1990", "90~95", "95~00", "00~05", "05~10", "10~15", ">=2015"), 
                      right = F, ordered_result = T)
houses$num_cg <- cut(houses$num, breaks = c(0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, Inf),
                     labels = c("0~1", "1~2", "2~3", "3~4", "4~5", "5~6", "6~7", "7~8", "8~9", "9~10", ">10"),
                     ordered_result = T)
houses$price_cg <- cut(houses$price, breaks = c(0, 10000, 20000, 30000, 40000, 50000, 60000, 70000, 80000, 90000, 100000, Inf),
                       labels = c("0~1万", "1~2万", "2~3万", "3~4万", "4~5万", "5~6万", "6~7万", "7~8万", "8~9万", "9~10万", ">10万"),
                       ordered_result = T)