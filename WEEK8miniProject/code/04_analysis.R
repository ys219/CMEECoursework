rm(list = ls())
setwd('/home/yige/Documents/CMEECoursework/WEEK8miniProject/code/')
fr_data = read.csv('../data/CRat.csv',header = T, stringsAsFactors = FALSE)

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
best_fit_out = data_frame(out_put$ID,aic_best,bic_best,rsq_best) ; names(best_fit_out)[1] = 'ID'



# best_fit_out = read.csv('../data/best_fit_output.csv', header = T, stringsAsFactors = FALSE)
# # fr_data = fr_data[,colSums(is.na(fr_data)) == 0 ] ## remove incomplete columns(the ones with NA)
# # colnames(fr_data)
# # 
# # unique(fr_data$Res_Thermy)
# # unique(fr_data$Res_ForagingMovement)

# extracct thermo type information & add it to best fit output
Thermy = unique(fr_data[c('ID',"Con_Thermy","Res_Thermy")]); Thermy = Thermy[order(Thermy$ID),]
best_fit_out = merge(best_fit_out,Thermy, by = "ID")

# extract habitat information & add it to best fit output
Habitat = unique(fr_data[c("ID","Habitat")]); Habitat = Habitat[order(Habitat$ID),]
best_fit_out = merge(best_fit_out,Habitat, by = "ID")

# extract foraging types & add it to best fit output
Foraging = unique(fr_data[c('ID', 'Con_ForagingMovement','Res_ForagingMovement')]) ; Foraging = Foraging[order(Foraging$ID),]
# generalise foraging type description.
Foraging$Con_ForagingMovement[Foraging$Con_ForagingMovement == "Sessile"] = "sessile" ; Foraging$Res_ForagingMovement[Foraging$Res_ForagingMovement == "passive"] = "sessile"
## combind the foraging type information
Foraging$predation_type = paste('C:',Foraging$Con_ForagingMovement,';R:',Foraging$Res_ForagingMovement)
Foraging = subset(Foraging, select = c(ID, predation_type))
# & add it to best fit output
best_fit_out = merge(best_fit_out,Foraging, by = "ID")

#create tables for analysis
habi_table = table(best_fit_out$Habitat,best_fit_out$aic_best)
ther_con_table = table(best_fit_out$Con_Thermy,best_fit_out$aic_best)
ther_res_table = table(best_fit_out$Res_Thermy,best_fit_out$aic_best)
feeding_table = table(best_fit_out$predation_type,best_fit_out$aic_best)
# chi_square tests
chisq.test(habi_table)
chisq.test(ther_con_table)
chisq.test(ther_res_table)
chisq.test(feeding_table)

# plot the results
habi_plot = subset(best_fit_out, select = c(aic_best,Habitat))
ggplot(habi_plot,aes(x = Habitat, fill = aic_best))+geom_bar(position = "fill")

ther_con_plot = subset(best_fit_out,select = c(aic_best,Con_Thermy))
ggplot(ther_con_plot,aes(x = Con_Thermy, fill = aic_best))+geom_bar(position = "fill")

ther_res_plot = subset(best_fit_out,select = c(aic_best,Res_Thermy))
ggplot(ther_res_plot,aes(x = Res_Thermy, fill = aic_best))+geom_bar(position = "fill")


feeding_plot = subset(best_fit_out,select = c(aic_best,predation_type))
ggplot(feeding_plot,aes(x = predation_type, fill = aic_best))+geom_bar(position = "fill")




