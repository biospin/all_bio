
# parallel 패키지를 공부해보자.
#install.packages("parallel", repos = "http://cran.nexr.com")
require(parallel) 

system.time( lapply(1:4, function(xx){ Sys.sleep(5) }) )

# 아래 코드를 윈도우즈와 다른 OS에서 각각 실행해보고 실행시간을 비교하자.
# 윈도주에서 도커를 활용해서 다른 OS 에서 테스트하는 방법
# docker run --rm -ti -p 8787:8787  rocker/rstudio
# http://192.168.99.100:8787
system.time( mclapply(1:4, function(xx){ Sys.sleep(5) }) )



# 그럼 윈도우즈에서는 어떻게 사용할까 ?
# "cluster" 방법을 이용함.
wait.then.square <- function(xx){
    # Wait for one second
    Sys.sleep(1);
    # Square the argument 
    xx^2 } 
a.global.variable <- Diagonal(3) 

    
system.time(
    serial.output <- lapply( 1:4,
                             function(xx) {
                                 return( wait.then.square(xx) + a.global.variable )
                             })
)

## 자식 프로세스를 생성해서 cluster 구성
cl <- makeCluster( 4 )

# cluster을 구성하는 자식 프로세스에 필요한 R 패키지를 로드시킴.
par.setup <- parLapply( cl, 1:length(cl),
                        function(xx) {
                            require(Matrix) 
                        })

#  필요한 R 객체을 배포함.
clusterExport( cl, c('wait.then.square', 'a.global.variable') )

# 실행
system.time(
    par.output <- parLapply(cl, 1:4,
                        function(xx) {
                            return( wait.then.square(xx) + a.global.variable )
                        })
)

# 끝났으면 꼭  cluster을 종료함.
stopCluster(cl)

# 두개의 결과 비교.
all.equal(serial.output, par.output)
serial.output
par.output

source('mclapply.hack.R')
system.time( mclapply(1:4, function(xx){ Sys.sleep(10) }) )




