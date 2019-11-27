setwd('/home/yige/Documents/CMEECoursework/WEEK6/code')
western<- read.csv("../data/western_banded_gecko.csv", header = FALSE, stringsAsFactors = FALSE)
bent<- read.csv("../data/bent-toed_gecko.csv", header = FALSE, stringsAsFactors = FALSE)
leopard<- read.csv("../data/leopard_gecko.csv", header = FALSE, stringsAsFactors = FALSE)

#### omitting all the polymorphic sites(by replacing with NA).
### bent-toed
bentpoly<-c()
for(i in 1:ncol(bent)) {
  if(length(unique(bent[,i])) !=1 ) {
    bent[,i]<- c(rep(NA, nrow(bent)))
    # bentpoly<- c(bentpoly, i)
    }
}
bent<- unique(bent)

### leopard
leopoly<-c()
for(i in 1:ncol(leopard)) {
  if(length(unique(leopard[,i])) !=1 ) {
    leopard[,i]<- c(rep(NA, nrow(leopard)))
    # leopoly<- c(leopoly, i)
  }
}
leopard<- unique(leopard)

### western
westpoly<-c()
for(i in 1:ncol(western)) {
  if(length(unique(western[,i])) !=1 ) {
    western[,i]<- c(rep(NA, nrow(western)))
    # westpoly<- c(westpoly, i)
  }
}
western<- unique(western)


#### calculate the divergence frequency
##bent & leopard
total = 0
diverged = 0 
for(i in 1:ncol(bent)) {
  if(is.na(bent[,i]) == FALSE & is.na(leopard[,i]) == FALSE ) {total= total+1}
  if(is.na(bent[,i]) == FALSE & is.na(leopard[,i]) == FALSE & bent[,i] != leopard[,i]) {diverged= diverged+1}
}

b_l_divergence<- diverged/total
b_l_divergence

##bent & western
total = 0
diverged = 0 
for(i in 1:ncol(bent)) {
  if(is.na(bent[,i]) == FALSE & is.na(western[,i]) == FALSE ) {total= total+1}
  if(is.na(bent[,i]) == FALSE & is.na(western[,i]) == FALSE & bent[,i] != western[,i]) {diverged= diverged+1}
}

b_w_divergence<- diverged/total
b_w_divergence

## leopard & western
total = 0
diverged = 0 
for(i in 1:ncol(leopard)) {
  if(is.na(leopard[,i]) == FALSE & is.na(western[,i]) == FALSE ) {total= total+1}
  if(is.na(leopard[,i]) == FALSE & is.na(western[,i]) == FALSE & leopard[,i] != western[,i]) {diverged= diverged+1}
}

l_w_divergence<- diverged/total
l_w_divergence
#sort the divergence in order
######################################
#the species tree looks like: L,(W,B)#
######################################

###calculate the mutation rate 
## from divergence betwee B&L and the time given
mu_rate<- b_l_divergence/(2*30)
mu_rate

###calculate the divergenc time between B&W
b_w_time<- b_w_divergence/(2*mu_rate)
b_w_time
#########################################################
# divergence time between B&w is 12.1 million years ago.#
#########################################################

### Bonus question
# easy way: calculate it with time difference
l_bw_time<- 30 - b_w_time
l_bw_divergence<- 2*l_bw_time*mu_rate
l_bw_divergence

# hard way: infer the sequence of B&w common ancestor
