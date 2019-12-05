# CMEE 2019 HPC excercises R code HPC run code proforma

rm(list=ls())
graphics.off()
# functions 
# Qeustion 1
species_richness <- function(community){
  richness = length(unique(community))
  return(richness)
}

# Question 2
init_community_max <- function(size){
  initmax = seq(1,size,by = 1)
  return(initmax)
}

# Question 3
init_community_min <- function(size){
  initmin = rep(1,size)
  return(initmin)
}

# Question 4
choose_two <- function(max_value){
  sample(max_value,2,replace = FALSE)
}

# Question 5
neutral_step <- function(community){
  sampling = choose_two(length(community))
  community=replace(community,sampling[1],community[sampling[2]])
  return(community)
}
# Question 6
neutral_generation <- function(community){
  steps = length(community)/2
  steps = sample(c(ceiling(steps),floor(steps)),1)
  for (i in 1:steps){
    community=neutral_step(community)
  }
  return(community)
}

# Question 7
neutral_time_series <- function(community, duration)  {
  myv=c(species_richness(community))
  for (i in 1:duration){
    community=neutral_generation(community)
    richness=species_richness(community)
    myv = c(myv,richness)
  }
  return(myv)
}

# Question 8
question_8 <- function(community=100,duration=200) {
  # clear any existing graphs and plot your graph within the R window
  try(dev.off(),silent = T)
  plot(neutral_time_series(init_community_max(community),duration),
       xlab = "Generation",
       ylab = "Species richness",
       type = "l")
  return("The states will always converge to species richness = 1, if we wait long enough. That is because no new species would come up (i.e. no speciation) in this system,the species richness would only be declining until it reaches 1.")
}

# Question 9
neutral_step_speciation <- function(community,speciation_rate)  {
  rate = runif(1,min = 0, max = 1)
  
  if (rate <= speciation_rate){
    
    newspp = max(community)+1
    sampling = sample(1:length(community),1)
    community[sampling] = newspp
    
  } else {
    community= neutral_step(community)
    
  }
  return(community)
}

# Question 10
neutral_generation_speciation <- function(community,speciation_rate)  {
  steps = length(community)/2
  steps = sample(c(ceiling(steps),floor(steps)),1)
  for (i in 1:steps){
    community = neutral_step_speciation(community,speciation_rate)
  }
  return(community)
}


# Question 11
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  myv=c(species_richness(community))
  for (i in 1:duration){
    community=neutral_generation_speciation(community,speciation_rate)
    richness=species_richness(community)
    myv = c(myv,richness)
  }
  return(myv)
}

# Question 12
question_12 <- function(community = 100, speciation_rate = 0.1, duration = 200)  {
  # clear any existing graphs and plot your graph within the R window
  try(dev.off(),silent = T)
  plot(neutral_time_series_speciation(init_community_max(community),speciation_rate,duration),
       xlab = "Generation",
       ylab = "Species richness",
       type = "l",
       col = "blue")
  lines(neutral_time_series_speciation(init_community_min(community),speciation_rate,duration),
        col = "red")
  legend("topright",legend = c("Max initi states","Min initi states"),
         col = c("blue","red"), 
         lty = 1, cex = 0.5,
         box.lty = 0)
  return("The species richness will converge to a similar level over many generations, regardless the initial states. 
         why?")
}

# Question 13
species_abundance <- function(community)  {
  community = as.data.frame(sort(table(community),decreasing = TRUE))
  return(community[,2])
}

# Question 14
octaves <- function(abundance_vector) {
  ab = log(abundance_vector,2)
  ab = floor(ab)+1
  bin = tabulate(ab)
  return(bin)
}


# Question 15
sum_vect <- function(x, y) {
  if (length(x) > length(y)){
    
    y = c(y,rep(0,length(x)-length(y)))
    sum= x+y
    
  } else if(length(x) < length(y)) {
    
    x = c(x,rep(0,length(y)-length(x)))
    sum = x+y
    
  } else {
    sum = x+y
  }
  return(sum)
}

# Question 16 
question_16 <- function(communitysize = 100 , speciation_rate = 0.1, duration = 2200, burn_in = 200)  {
  # clear any existing graphs and plot your graph within the R window
  # spprich
  # st = seq(220,2200,20)
  # end = seq(201,2200, 20)
  try(dev.off(), silent = TRUE)
  community1 = init_community_max(communitysize)
  community2 = init_community_min(communitysize)
  octsum1 = c()
  octsum2 = c()
  for (i in 1:duration){
    community1 = neutral_generation_speciation(community1, speciation_rate)
    abundance1 = species_abundance(community1)
    oct1 = octaves(abundance1)
    
    community2 = neutral_generation_speciation(community2, speciation_rate)
    abundance2 = species_abundance(community2)
    oct2 = octaves(abundance2)
    if (i > burn_in  & i%%20 == 0){
      octsum1 = sum_vect(octsum1, oct1)
      octsum2 = sum_vect(octsum2, oct2)
      
    }
  }
  octmean1 = octsum1/100
  octmean2 = octsum2/100
  barplot(octmean1,
          names.arg = c("<2","2-4","4-8","8-16","16-32","32-64"),
          xlab = "abundance of spp",
          ylab = "number of spp"
  )
  return("type your answer")
}

# Question 17
cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name)  {
  ##1 :
  community = init_community_min(size)
  generation = 0
  time_series = c()
  octlist = list()
  start_time = proc.time()[3]
  ## simulations within the wall_time length:
  while((proc.time()[3] - start_time)/60 <  wall_time){
    community = neutral_generation_speciation(community, speciation_rate)
    generation = generation + 1
    ## burn in time :
    if (generation < burn_in_generations & generation %% interval_rich == 0 ){
      time_series = c(time_series, species_richness(community))}
    ## intervals the recoed the octaarves:
    if (generation %% interval_oct ==0){
      abundance = species_abundance(community)
      oct = octaves(abundance)
      octlist[[length(octlist)+1]] = oct}
  }
  thetime = paste(proc.time()[3]-start_time, "seconds")
  save(time_series, octlist, community, thetime,
       speciation_rate, size, wall_time, interval_rich, interval_oct,burn_in_generations,
       file = output_file_name)
}
########################
### MAIN CLUSTER RUN ###
########################
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
