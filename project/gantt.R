rm(list=ls())
require(ggplot2)
require(reshape2)
gantt <- data.frame(
  tasks = as.factor(c("8","7","6", "5", "4", "3","2","1")),
  start = as.Date(c("2019-12-09", "2020-01-06", "2020-03-30","2020-05-18","2020-01-06","2020-02-03","2020-06-01","2020-07-27")),
  end = as.Date(c('2020-02-17', '2020-03-30', '2020-06-15','2020-07-13','2020-02-17','2020-06-01','2020-08-24','2020-08-24')),
  type = as.factor(c(rep("Project",4),rep("Report writing",4)))
)
mdfr <- melt(gantt, measure.vars = c("start", "end"))
# mdfr$tasks<- as.character(mdfr$tasks)
ggplot(mdfr, aes(value, tasks, color = type)) + 
  geom_line(size = 20) +
  scale_y_discrete( labels = c("Report:Abstract","Report:Results","Report:Methods","Report:Introduction","Reference Profile Assessing","Testing Data Handling","Reference Profile Construction","Literature Review"))+
  scale_x_date(breaks = seq.Date(as.Date("2019-12-09"),as.Date("2020-08-27"), by = "month"),labels = c("Dec","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug"))+
  scale_color_manual(values=c("#E69F00", "#56B4E9"), name= NULL) +
  theme_classic()+
  xlab(NULL) + 
  ylab(NULL)

seq.Date(as.Date("2019-12-09"),as.Date("2020-08-27"), by = "month")


  