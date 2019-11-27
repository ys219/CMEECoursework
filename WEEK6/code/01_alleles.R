setwd('/home/yige/Documents/CMEECoursework/WEEK6/code')
data<- read.csv('../data/bears.csv', header = FALSE)
str(data)


### 1)how many SNPs and position of SNPs
# 1. go through the 
snps<- c()
for(i in 1:ncol(data)) {
  if(length(unique(data[,i])) !=1 ) {snps<- c(snps, i)}
     }
cat("there are", length(snps), "SNPs")
cat("SNPs are in positions", snps)


#### 2)allele frequency for ech SNPs

# 1. extract the alleles using levels and save as a vector
# 2.calculate the frequency by measuring the length
   #which()可以用来限定条件
# 3. print them out with cat()
freq<- c()
par(mfrow=c(4,4),mar=c(1.5,1.5,1.5,1.5))
for (i in snps) {
  alleles<- c(levels(data[,i]))
  freq1<- length(which(data[,i]== alleles[1]))/length(data[,i])
  freq2<- length(which(data[,i]== alleles[2]))/length(data[,i])
  cat("\n\nSNP at location", i, "has alleles", alleles, "\nfrequency for allele", alleles[1],"is", freq1,"\nfrequency for allele", alleles[2],"is", freq2)
  hist(as.numeric(data[,i]), main=c("position",as.character(i)))
  }

### 3) genotype frequences:
data<- read.csv('../data/bears.csv', header = FALSE,stringsAsFactors = FALSE)
str(data)
gtype<-as.data.frame(matrix(nrow = 20, ncol = 0))
for (i in snps){
  tmp<-c()
  for(a in seq(1, nrow(data), by= 2)){
    geno<-c(data[a,i], data[(a+1),i])
    tmp<-c(tmp,paste0(geno[order(geno)], collapse = ""))
  }
  gtype[paste("position",i,sep = "")] = tmp
  tmp= table(tmp)
  cat("\n\nIn position",i,"there are genotypes",names(tmp))
  for(b in 1:length(tmp)){
    freq<- c(unname(tmp[b])/20)
    cat("\nfrequency for", names(tmp[b])," is", freq)
  }
}





