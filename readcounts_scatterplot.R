
##estimating read counts for both Stefania and Tepuihyla main datasets

###1. Tepuihyla

reads <- read.table("read-counts-Tepuihyla.txt")
readsmatrix <- as.data.frame(reads)
readsmatrix
mean(readsmatrix$V2)
##result: [1] 1059669
median(readsmatrix$V2)
##result: [1] 764323
sd(readsmatrix$V2)
##result: [1] 1000323
stdev <- 1000323
average <- 1059669
stdev+average
##result=[1] 2059992
average-stdev
##result=[1] 59346

###
plot(readsmatrix$V2)
abline(h=764323, col="red") ##median
abline(h=1059669, col="blue") ##average
abline(h=2059992, col="gray") ##stdev up
abline(h=59346, col="gray") ##stdev down
###

###2. Stefania

reads <- read.table("read-counts-Stefania.txt")
readsmatrix <- as.data.frame(reads)
readsmatrix
mean(readsmatrix$V2)
##result: [1] 841618.7
median(readsmatrix$V2)
##result: [1] 577996.5
sd(readsmatrix$V2)
##result: [1] 841239.1
stdev <- 841239.1
average <- 841618.7
stdev+average
##result: [1] 1682858
average-stdev
##result: [1] 379.6

######
plot(readsmatrix$V2)
abline(h=577996.5, col="red") ##median
abline(h= 841618.7, col="blue") ##average
abline(h= 1682858, col="gray") ##stdev up
abline(h= 379.6, col="gray") ##stdev down



