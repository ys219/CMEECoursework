setwd('/home/yige/Documents/CMEECoursework/WEEK6/code')

northern<- as.matrix(read.csv("../data/killer_whale_North.csv", header = FALSE, stringsAsFactors = FALSE))
southern<- as.matrix(read.csv("../data/killer_whale_South.csv", header = FALSE, stringsAsFactors = FALSE))
# 使用循环时， matrix的速度要远远快于data frame

#### northern whales

## tajima estimator
northern_diff = 0 
for (i in 1:nrow(northern)) {
  for (a in 1:(i-1)){
    if(i-1 != 0 ){
     northern_diff = northern_diff + sum(abs(northern[i,]-northern[a,]))
    }
  }
}

n_northern = nrow(northern)
norther_pie= northern_diff/(n_northern*(n_northern-1)/2)

n_taji_size=norther_pie/(4*1e-8*50000)
###an alternative loop.
# for (i in 1:nrow(northern)) {
#   for (a in 1:(i-1)){
#     if(i-1 != 0 ){
#       for (c in 1:ncol(northern)){
#         if(northern[a,c] != northern[i,c]){score=score+1}
#       }
#     }
#   }
# }

## watterson's estimator
northern_S=0
n_snps<- c()
for(i in 1:ncol(northern)) {
  if(length(unique(northern[,i])) !=1 ) {
    northern_S = northern_S+1
    n_snps<- c(n_snps,i)
  }
}

northern_watterson= northern_S/(sum(1/1:(nrow(northern)-1)))
n_watt_size= northern_watterson/(4*1e-8*50000)
# Ne_S_watt <- watt_S / (4 * 1e-8 * len) 答案里为什么要多出一个len（50000）
# because the mutation rate given is for single site, so we need to multiply the 50000 sites 
# as more sites add up, mutation rate add up, we need to add nutation rate for each site up.



#### southern whales

## tajima estimator
southern_diff = 0 
for (i in 1:nrow(southern)) {
  for (a in 1:(i-1)){
    if(i-1 != 0 ){
      southern_diff = southern_diff + sum(abs(southern[i,]-southern[a,]))
    }
  }
}

n_southern = nrow(southern)
southern_pie= southern_diff/(n_southern*(n_southern-1)/2)
s_taji_size=southern_pie/(4*1e-8*50000)
## watterson's estimator
southern_S=0
s_snps<-c()
for(i in 1:ncol(southern)) {
  if(length(unique(southern[,i])) !=1 ) {
    southern_S = southern_S+1
    s_snps<-c(s_snps,i)
  }
}
sum(1/1:nrow(northern))
southern_watterson= southern_S/(sum(1/(1:(nrow(southern)-1))))
s_watt_size=southern_watterson/(4*1e-8*50000)


#### what we gonna do with tajima pie and watterson's estimator is use it to generate 
#### an effective population, this population size the recent(not current population size)
#### as population size is changeing over time, what we generated here is a expected(mixed)
#### of current and the past, some how averged? applying some other method, we can work it exactly when.



####SFS site frequency spectrum
### analysing no of alternative alleles in population(how many 1s on each site)

n_sfs<- apply(northern, 2, sum)
##remove 0 s
n_sfs[n_sfs==0]<- NA
n_sfs<-na.omit(n_sfs)
n_sfs<- table(as.vector(n_sfs))



s_sfs<- apply(southern, 2, sum)

s_sfs[s_sfs==0]<-NA
s_sfs<- na.omit(s_sfs)
s_sfs<- table(as.vector(s_sfs))


##  barplot
barplot(t(cbind(n_sfs,s_sfs)),beside = TRUE)


