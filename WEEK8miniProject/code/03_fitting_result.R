setwd('/home/yige/Documents/CMEECoursework/WEEK8miniProject/code/')
rm(list = ls())# clear workspace
require("ggplot2")
require("dplyr") # function select
require("tidyr") # function gather
# import raw data
# raw_data = read.csv('../data/fitting_data.csv', header = TRUE, stringsAsFactors = FALSE)

# import fitting output data
out_put = read.csv('../data/fitting_output.csv', header = TRUE, stringsAsFactors = FALSE)# data were sorted by ID
## extract fitting outputs
aic_out = select(out_put,ID, starts_with("AIC")) ; names(aic_out) = c('ID','hol_II','hol_III','hol_I','poly_cubic','poly_sq')# extract aic and rename column
bic_out = select(out_put,ID, starts_with('BIC')); names(bic_out) = c('ID','hol_II','hol_III','hol_I','poly_cubic','poly_sq')# extrac bic and rename column
rsq_out = select(out_put,ID, starts_with("R")); names(rsq_out) = c('ID','hol_II','hol_III','hol_I','poly_cubic','poly_sq')# extract R-square and rename column

## model selection:
aic_best = c()
for(i in 1:nrow(aic_out)){
  aic_best = c(aic_best, names(which.min(aic_out[i,2:6])))
  }

bic_best = c()
for(i in 1:nrow(bic_out)){
  bic_best = c(bic_best, names(which.min(bic_out[i,2:6])))
}

rsq_best = c()
for(i in 1:nrow(rsq_out)){
  rsq_best = c(rsq_best, names(which.max(rsq_out[i,2:6])))
}

## add output to new dataframe and rename the first column
best_fit = data_frame(out_put$ID,aic_best,bic_best) ; names(best_fit)[1] = 'ID'
# write.csv(best_fit, "../data/best_fit_output.csv")


best_fit_plot = gather(best_fit[2:3])
png(filename = "../results/03_best_fit.png",width = 480, height = 480)
ggplot(best_fit_plot, aes(x = key, fill = value))+
  geom_bar(position = "fill", color = "black")+
  theme_classic()+
  scale_fill_grey(start = 0.4, end = 1, labels = c("Hol I","Hol II","Hol III","Cubic Polynomial","Quadratic Polynimoal"))+
  labs(x = "Model Slection Criterion", y = "Proportion of best fit model")+
  scale_x_discrete(labels = c("AIC", "BIC"))
try(dev.off(),silent = TRUE)

ana_table= table(best_fit_plot)[1:2,]
## best fit portion of each model 
prop.table(table(best_fit_plot)[1,])
prop.table(table(best_fit_plot)[2,])

## check if AIC BIC perform differently
chisq.test(ana_table)## p = 0.9859

aic_out = gather(aic_out[2:6])
bic_out = gather(bic_out[2:6])
rsq_out = gather(rsq_out[2:6])
## violin plot
# vio = ggplot(data = aic_out, aes(x= key, y = value, fill = key))
# vio+geom_violin()
png(filename = "../results/03_AIC.png",width = 480, height = 480)
ggplot(data = aic_out, aes(x= key, y = value, fill = key))+
  geom_violin()+
  geom_boxplot(width = 0.2, na.rm = TRUE)+
  geom_abline(slope = 0,intercept = median(aic_out$value,na.rm = TRUE), linetype = "dashed", color = "grey")+
  ylim(-500,200)+
  theme_classic()+
  scale_fill_grey(start = 0.4, end = 1)+
  scale_x_discrete(labels = c("Hol I","Hol II","Hol III","Cubic","Quadratic"))+
  labs(x= "Models", y = "AIC")+
  theme(legend.position = "none")
try(dev.off(),silent = TRUE)
png(filename = "../results/03_BIC.png",width = 480, height = 480)
ggplot(data = bic_out, aes(x= key, y = value, fill = key))+
  geom_violin()+
  geom_boxplot(width = 0.2, na.rm = TRUE)+
  geom_abline(slope = 0,intercept = median(bic_out$value,na.rm = TRUE), linetype = "dashed", color = "grey")+
  ylim(-500,200)+
  theme_classic()+
  scale_fill_grey(start = 0.4, end = 1)+
  scale_x_discrete(labels = c("Hol I","Hol II","Hol III","Cubic","Quadratic"))+
  labs(x= "Models", y = "BIC")+
  theme(legend.position = "none")
try(dev.off(),silent = TRUE)
png(filename = "../results/03_rsq.png",width = 480, height = 480)
ggplot(data = rsq_out, aes(x= key, y = value, fill = key))+
  geom_violin()+
  geom_boxplot(width = 0.1, na.rm = TRUE)+
  geom_abline(slope = 0,intercept = median(rsq_out$value,na.rm = TRUE), linetype = "dashed", color = "grey")+
  ylim(0,1)+
  theme_classic()+
  scale_fill_grey(start = 0.4, end = 1)+
  scale_x_discrete(labels = c("Hol I","Hol II","Hol III","Cubic","Quadratic"))+
  labs(x= "Models", y = expression(R^2))+
  theme(legend.position = "none")
try(dev.off(),silent = TRUE)
