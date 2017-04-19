
# doParallel 와 foreach 공부해보자
# 출처 : https://cran.r-project.org/web/packages/doParallel/vignettes/gettingstartedParallel.pdf

# doParallel은 parallel패키지와 foreach패키지를 모두 사용함.
# parallel의 문제점인 윈도우의 호환문제를 해결함.

### 아주 중요 ### 
# foreach에서 doParallel을 사용하기 위해서 registerDoParallel 함수를 꼭 등록 

library(doParallel)
cl <- makeCluster(2)  # 자신의 PC의 core수. 보통 4개 있음.
registerDoParallel(cl)
foreach(i=1:3) %dopar% sqrt(i)

# 좀더 짧은 코드로는 
library(doParallel)
registerDoParallel(cores=2)
foreach(i=1:3) %dopar% sqrt(i)

# 내 PC의 core수에 맞게
detectCores()
library(doParallel)
registerDoParallel(cores=detectCores())
foreach(i=1:3) %dopar% sqrt(i)


# 병렬로 처리했을때와 안 했을때의 성능을 비교해보자.
# iris 데이터로 로지스틱회귀를 10,000번 돌려보자.
x <- iris[which(iris[,5] != "setosa"), c(1,5)]
trials <- 10000
ptime <- system.time({
     r <- foreach(icount(trials), .combine=cbind) %dopar% {
         ind <- sample(100, 100, replace=TRUE)
         result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
         coefficients(result1)
         }
     })[3]
ptime


stime <- system.time({
     r <- foreach(icount(trials), .combine=cbind) %do% {
         ind <- sample(100, 100, replace=TRUE)
         result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
         coefficients(result1)
         }
     })[3]
stime

# 과제1. 자신의 PC의 core수에 맞게 ptime을 다시 구해보자.
# 지금 해보세요. 
# 결과 => core수가 2배로 늘었다고 2배로 빨라지지는 않음.
# 왜 ????  parallel_example.R에서 힌트가 있음.


# %dopar% 에서 %do%로 변경해서 병렬처리를 순차처리로 변경가능함


# cluster을 종료하기 위해서는 stopCluster()함수 호출
stopCluster(cl)








