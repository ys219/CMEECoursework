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
best_fit = data_frame(out_put$ID,aic_best,bic_best,rsq_best) ; names(best_fit)[1] = 'ID'
# write.csv(best_fit, "../data/best_fit_output.csv")

best_fit_plot = gather(best_fit[2:4])
ggplot(best_fit_plot, aes(x = key, fill = value))+geom_bar(position = "fill")+theme_classic()
ana_table= table(best_fit_plot)[1:2,]
## check if AIC BIC perform differently
chisq.test(ana_table)## p = 0.9859

aic_out = gather(aic_out[2:6])
bic_out = gather(bic_out[2:6])
rsq_out = gather(rsq_out[2:6])
## violin plot
# vio = ggplot(data = aic_out, aes(x= key, y = value, fill = key))
# vio+geom_violin()
ggplot()+geom_violin(data = aic_out, aes(x= key, y = value, fill = key))
ggplot()+geom_violin(data = bic_out, aes(x= key, y = value, fill = key))
ggplot()+geom_violin(data = rsq_out, aes(x= key, y = value, fill = key))+ylim(0,1)


