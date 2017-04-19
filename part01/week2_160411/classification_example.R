
# 1. 데이터 로드
setwd("D:/Work_Git/all_bio/part01/week2_160411")
load("expedia_train2.Rdata")

# 2. 데이터 탐색
head(expedia_train2)
dim(expedia_train2)
str(expedia_train2)

summary(expedia_train2$hotel_cluster)
hotel_cluster.table <- table(expedia_train2$hotel_cluster)
order( hotel_cluster.table ,decreasing = TRUE )

# 3. 로지스틱 회귀로 변환
hotel_cluster.table[92]
hotel_cluster.table[49]

expedia_train3 <- subset(expedia_train2, hotel_cluster %in% c(91, 48))
summary(expedia_train3)

# 4. 범주형 변수로 변환
expedia_train3$site_name <- as.factor( expedia_train3$site_name )
expedia_train3$posa_continent <- as.factor( expedia_train3$posa_continent )
expedia_train3$user_location_country <- as.factor( expedia_train3$user_location_country )
expedia_train3$is_mobile <- as.factor( expedia_train3$is_mobile )
expedia_train3$is_package <- as.factor( expedia_train3$is_package )
expedia_train3$channel <- as.factor( expedia_train3$channel )
expedia_train3$srch_destination_id <- as.factor( expedia_train3$srch_destination_id )
expedia_train3$srch_destination_type_id <- as.factor( expedia_train3$srch_destination_type_id )
expedia_train3$hotel_continent <- as.factor( expedia_train3$hotel_continent )
expedia_train3$hotel_country <- as.factor( expedia_train3$hotel_country )
expedia_train3$hotel_market <- as.factor( expedia_train3$hotel_market )

# 5. 유의미한 범주형 변수 선택
require(ggplot2)
#qplot( expedia_train3$site_name )
qplot( expedia_train3$posa_continent )
#qplot( expedia_train3$user_location_country )
qplot( expedia_train3$is_mobile )
qplot( expedia_train3$is_package )
qplot( expedia_train3$channel )
#qplot( expedia_train3$srch_destination_id )
qplot( expedia_train3$srch_destination_type_id )
qplot( expedia_train3$hotel_continent )
#qplot( expedia_train3$hotel_country )
#qplot( expedia_train3$hotel_market )

library(dplyr)
expedia_train4 <- select(expedia_train3, posa_continent, is_mobile, 
                         is_package, channel, srch_destination_type_id,
                         srch_ci, srch_co, srch_adults_cnt, srch_children_cnt, 
                         srch_rm_cnt, hotel_continent, hotel_cluster ) 
summary(expedia_train4)

set.seed(1)
n = nrow(expedia_train4)
trainIndex = sample(1:n, size = round(0.7*n), replace=FALSE)
expedia.train = expedia_train4[trainIndex ,]
expedia.test = expedia_train4[-trainIndex ,]


expedia.train.glm <- glm(hotel_cluster ~ . , data = expedia.train )
summary(expedia.train.glm)




