#------------------------------------------#
상관분석 및 편상관분석
#------------------------------------------#

library(lattice)


##자료 입력 및 관찰
healthdata = read.csv("C:/Users/Jihye/Desktop/통계/그림으로 이해하는 닥터 배의 술술 보건의학통계/6_correlation_and_regression.csv")
attach(healthdata)
healthdata[c(1:20),]

## 산점도 및 상관분석
par(mfrow=c(2,2))
pairs(healthdata)
cor(healthdata,use="pairwise.complete.obs")

##from BIRC

#패키지 설치 및 실행
install.packages("RcmdrMisc")
library(RcmdrMisc)
install.packages("stringi")
library(stringi)


#분석
with(healthdata, cor.test(weight, height, alternative="two.sided", method="pearson"))
with(healthdata, cor.test(weight, BMI, alternative="two.sided", method="pearson"))
with(healthdata, cor.test(waistline, BMI, alternative="two.sided", method="pearson"))




install.packages("ppcor")
library(ppcor)

pcor.test(healthdata$waisteline, healthdata$BMI, healthdata$weight, method="pearson")
pcor.test(healthdata[,4], healthdata[,5], healthdata[,3], method="pearson")



detach(healthdata)



#--------------------------------------------------------#
Spearman의 순위상관분석
#---------------------------------------------------------#
##자료입력 및 관찰
healthdata = read.csv("C:/Users/Jihye/Desktop/통계/그림으로 이해하는 닥터 배의 술술 보건의학통계/6_spearman.csv")
attach(healthdata)
head(healthdata)


##순위상관분석
cor(healthdata,use="complete.obs",method="spearman")
cor(healthdata,use="complete.obs",method="kendall")

detach(healthdata)


#--------------------------------------------------------#
#단순회귀분석
#---------------------------------------------------------#
##자료 입력 및 관찰
healthdata = read.csv("C:/Users/Jihye/Desktop/통계/그림으로 이해하는 닥터 배의 술술 보건의학통계/6_correlation_and_regression.csv")
attach(healthdata)
healthdata[c(1:20),]

##단순회귀분석, BMI와 waistline

myresult=lm(BMI~waistline)
anova(myresult)
summary(myresult)
par(mfrow=c(2,2))
plot(myresult)
#추정된 통계식 : BMI=-0.3956+0.331*Waistline


#--------------------------------------------------------#
#다주회귀분석
#---------------------------------------------------------#중

healthdata = read.csv("C:/Users/Jihye/Desktop/통계/그림으로 이해하는 닥터 배의 술술 보건의학통계/6_correlation_and_regression.csv")
attach(healthdata)
healthdata[c(1:20),]


##모든변수를 입력하여 다중회귀분석 시행
myresultall = lm(SBP~.,data = healthdata)
anova(myresultall)
summary(myresultall)
par(mfrow=c(2,2))
plot(myresultall)


##단계선택법으로 다중회귀분석 시행
myresultstep = step(lm(SBP~., data = healthdata), healthdata, derection = "both")
anova(myresultstep)
summary(myresultstep)
par(mfrow=c(2,2))
plot(myresultstep)

##최종회귀모형의 선택
myresultfinal=lm(SBP~age + BMI,data=healthdata)
anova(myresultfinal)
summary(myresultfinal)
par(mfrow=c(2,2))
plot(myresultfinal)


detach(healthdata)

