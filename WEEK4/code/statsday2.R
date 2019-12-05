setwd("../data/HandOutsandData'18")
data<- read.table("SparrowSize.txt", header = T)

###########tarsus
dtarsus <- subset(data , data$Tarsus != "NA" ,)
seTarsus <- sqrt(var(dtarsus $ Tarsus) / length(dtarsus $ Tarsus))
seTarsus
d2001 <- subset( dtarsus, dtarsus $ Year == 2001)
seTarsus2001 <- sqrt(var(d2001$Tarsus) / length(d2001$Tarsus))
seTarsus2001


t.test(d2001$Tarsus, mu=18.5 , na.rm =T)

#t.test (d2001~)
quantile(d2001$Tarsus , 0.05)
quantile(d2001$Tarsus , 0.95)
##########body mass
dmass <- subset(data ,data$Mass != "NA")
seMass <- sqrt(var(dmass$Mass) / length(dmass$Mass))
seMass

#########bill

dbill <- subset(data , data$Bill != "NA")
sebill <- sqrt(var(dbill$Bill) / length(dbill$Bill))
sebill
quantile(dbill$Bill , 0.05)
quantile(dbill$Bill , 0.95)

########wing

dwing <- subset(data , data$Wing != "NA" , )
dwing2001 <-subset(dwing , dwing$Year == 2001)
sewing <- sebill <- sqrt(var(dbill$Bill) / length(dbill$Bill))

wingt <- t.test(dwing2001$Wing, mu=mean(dwing$Wing))
wingt
######t.test
t.test1 <- t.test(data$Mass~data$Sex.1)
t.test1

t.test2 <- t.test(data$Mass~data$Sex)
t.test2
######male & female wing 

##2001
mf2001t <- t.test(dwing2001$Wing~dwing2001$Sex)
mf2001t
mfttest <- t.test(dwing$Wing~dwing$Sex)
mfttest
##

require(pwr)


effective_size_=5/sd(dwing$Wing)

pwr.t.test(d=(0-5)/effective_size_, power = 0.8, sig.level = .05, type = "two.sample", alternative = "two.sided")
