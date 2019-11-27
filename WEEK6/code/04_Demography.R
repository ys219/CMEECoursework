setwd('/home/yige/Documents/CMEECoursework/WEEK6/code')

alleles<- as.matrix(read.csv("../data/turtle.csv",header = FALSE, stringsAsFactors = FALSE,colClasses=rep("numeric", 2000)))

genotypes<- as.matrix(read.csv('../data/turtle.genotypes.csv', header = FALSE, stringsAsFactors = FALSE))


# fa<-c()
# fb<-c()
# fc<-c()
# fd<-c()

# fb<-c(fb,apply(alleles[21:40],MARGIN = 2, sum))
# fc<-c(fa,apply(alleles[41:60],MARGIN = 2, sum))
# fd<-c(fa,apply(alleles[61:80],MARGIN = 2, sum))

Fst_fun<- function(fa,fb) {
  fa<- apply(fa, MARGIN = 2, sum)/nrow(fa)
  fb<- apply(fb, MARGIN = 2, sum)/nrow(fb)
  Fst<- rep(NA, length(fa))
  # create a empty vector for Fst s.
  for (i in 1:length(fa)){
    Hs<- (2*fa[i]*(1-fa[i])+2*fb[i]*(1-fb[i]))/2
    Ht<- (2*(fa[i]+fb[i])/2)*(1-(fa[i]+fb[i])/2)
    #work out Hs and Ht 
    Fst[i]<- (Ht- Hs)/Ht
  }
  mean(Fst, na.rm = TRUE)
}
snps <- which(apply(FUN=sum, X=data2, MAR=2)/(nrow(data2))>0.03)
## to ignore some positions that have very little amount of derived alleles(would be considered as noise.)
fst_ab<- Fst_fun(alleles[1:20,], alleles[21:40,])  
fst_bc<- Fst_fun(alleles[21:40,], alleles[41:60,])  
fst_cd<- Fst_fun(alleles[41:60,], alleles[61:80,])  
fst_ac<- Fst_fun(alleles[1:20,], alleles[41:60,])  
fst_bd<- Fst_fun(alleles[21:40,], alleles[61:80,])  
fst_ad<- Fst_fun(alleles[1:20,], alleles[61:80,])  

