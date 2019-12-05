# CMEE 2019 HPC excercises R code HPC run code proforma

rm(list=ls())
graphics.off()
# good practice 
source("ySun_HPC_2019_main.R")

#Question 18:
iter = as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))

#### setting of iteration for local test:
# iter = sample(1:100,1)

## fixed parameters
specia_rate = 0.005849
wall_t = 690
interval_r = 1
## set seed
set.seed(iter)

## sizes
sizes <-c(500,1e3,25e2,5e3)

## different group of simulation with differnt community size
cluster_run(speciation_rate = specia_rate, size = sizes[1+iter%%4], wall_time = wall_t,
            interval_rich = interval_r, interval_oct = sizes[1+iter%%4]/10, 
            burn_in_generations = 8*sizes[1+iter%%4],
            output_file_name = paste0("cluster_run_seed_",iter,".rda"))






## my old and silly long version
# if( iter %% 4 == 1 ){
#   cluster_run(speciation_rate = specia_rate, size = 500, wall_time = wall_t,
#               interval_rich = interval_r, interval_oct = 500/10, 
#               burn_in_generations = 500*8,
#               output_file_name = paste("../results/cluster_run_seed_",iter,".rda"))
# } else if ( iter %% 4 == 2 ){
#   cluster_run(speciation_rate = specia_rate, size = 1000, wall_time = wall_t,
#               interval_rich = interval_r, interval_oct = 1000/10, 
#               burn_in_generations = 1000*8,
#               output_file_name = paste0("../results/cluster_run_seed_",iter,".rda"))
#   
# } else if ( iter %% 4 == 3 ){
#   cluster_run(speciation_rate = specia_rate, size = 2500, wall_time = wall_t,
#               interval_rich = interval_r, interval_oct = 2500/10, 
#               burn_in_generations = 2500*8,
#               output_file_name = paste0("../results/cluster_run_seed_",iter,".rda"))
#   
# } else {
#   cluster_run(speciation_rate = specia_rate, size = 5000, wall_time = wall_t,
#               interval_rich = interval_r, interval_oct = 5000/10, 
#               burn_in_generations = 5000*8,
#               output_file_name = paste0("../results/cluster_run_seed_",iter,".rda"))
#   
# }
# 

