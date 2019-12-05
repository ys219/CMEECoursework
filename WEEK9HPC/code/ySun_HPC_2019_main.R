# CMEE 2019 HPC excercises R code main proforma
# you don't HAVE to use this but it will be very helpful.  If you opt to write everything yourself from scratch please ensure you use EXACTLY the same function and parameter names and beware that you may loose marks if it doesn't work properly because of not using the proforma.

name <- "Yige Sun"
preferred_name <- "Yige"
email <- "ys219@ic.ac.uk"
username <- "ys219"
personal_speciation_rate <- 0.002 # will be assigned to each person individually in class and should be between 0.002 and 0.007

# Question 1
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

# neutral_time_series <- function(community, duration)  {
#   print("initial condition is")
#   print(community)
#   for (i in 1:duration){
#     community=neutral_generation(community)
#     print(paste("generation", i, "looks like"))
#     print(community)
#   }
# }


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

# Questions 18 and 19 involve writing code elsewhere to run your simulations on the cluster

# Question 20 
process_cluster_results <- function()  {
  # clear any existing graphs and plot your graph within the R window
  combined_results <- list() #create your list output here to return
  return(combined_results)
}

# Question 21
question_21 <- function()  {
  return( list(log(8,3),"When width increase by 3, size (in 2D)increase 8, therefore demension increase log(8)/log(3)"))
}
log(8,3)
# Question 22
question_22 <- function()  {
  return(list(log(20,3),"When width increase by 3, size (in 3D) increase 20, therefore demension increase log(20)/"))
}

# Question 23
chaos_game <- function()  {
  graphics.off()
  # clear any existing graphs and plot your graph within the R window
  dots = list(c(0,0),c(3,4),c(4,1))
  X = c(0,0)
  plot(x=X[1], y=X[2], cex = 0.5 , pch = 16 , xlim = c(-1,5), ylim = c(-1,5))
  sta = proc.time()[3]
  while(proc.time()[3]-sta <30){
    choice = sample(1:3,1)
    X = (dots[[choice]]+X)/2
    points(x=X[1], y=X[2], cex = 0.5 , pch = 16)
  }

  return("type your written answer here")
}

# Question 24
turtle <- function(start_position, direction, length)  {
  next_point = c(start_position[1]+length*cos(direction),start_position[2]+length*sin(direction))
  lines(x = c(start_position[1],next_point[1]), y = c(start_position[2],next_point[2]))
  return(next_point) # you should return your endpoint here.
}

# Question 25
elbow <- function(start_position, direction, length)  {
  next_point  = turtle(start_position, direction, length)
  start_position = next_point
  direction = direction-pi/4
  length = 0.95*length
  next_point  = turtle(start_position, direction , length)
  
}

# Question 26
spiral <- function(start_position, direction, length)  {
  next_point  = turtle(start_position, direction, length)
  if (length <= 2e-30){
    return("some comments")
  }
  spiral(next_point, direction-pi/4, 0.95*length)
}

# Question 27
draw_spiral <- function()  {
  graphics.off()
  plot(x=0,y=0,xlim = c(0,2.5), ylim = c(-1.5,1.5),cex = 0.1, pch = 16)
  spiral(c(0,0),direction = pi/3,length = 1)
}

# Question 28
tree <- function(start_position, direction, length)  {
  next_point  = turtle(start_position, direction, length)
  if (length >= 0.05){
    tree(next_point, direction-pi/4 , 0.65*length)
    tree(next_point, direction+pi/4 , 0.65*length)
  }
  
  return("some comments")
}
  
draw_tree <- function()  {
  graphics.off()
  plot(x=10,y=10,xlim = c(0,20), ylim = c(-10,5),cex = 0.1, pch = 16)
  tree(c(10,-10),direction = pi/2,length = 5)
  # clear any existing graphs and plot your graph within the R window
}

# Question 29
fern <- function(start_position, direction, length)  {
  next_point  = turtle(start_position, direction, length)
  if (length >= 0.05){
    fern(next_point, direction+pi/4 , 0.38*length)
    fern(next_point, direction , 0.87*length)
  }
}
draw_fern <- function()  {
  graphics.off()
  plot(x=10,y=10,xlim = c(0,20), ylim = c(-10,30),cex = 0.1, pch = 16)
  fern(c(10,-10),direction = pi/2,length = 5)
  # clear any existing graphs and plot your graph within the R window
}

# Question 30
fern2 <- function(start_position, direction, length, dir)  {
  next_point  = turtle(start_position, direction, length)
  if (length >= 0.05){
    fern2(next_point, direction+dir*pi/4 , 0.38*length, dir)
    dir = -1*dir
    fern2(next_point, direction , 0.87*length, dir)
  }
}

draw_fern2 <- function()  {
  graphics.off()
  plot(x=10,y=10,xlim = c(0,20), ylim = c(-10,30),cex = 0.1, pch = 16)
  fern2(c(10,-10),direction = pi/2,length = 5, dir = 1)
  # clear any existing graphs and plot your graph within the R window
}

# Challenge questions - these are optional, substantially harder, and a maximum of 16% is available for doing them.  

# Challenge question A
Challenge_A <- function() {
  # clear any existing graphs and plot your graph within the R window
}

# Challenge question B
Challenge_B <- function() {
  # clear any existing graphs and plot your graph within the R window
}

# Challenge question C
Challenge_C <- function() {
  # clear any existing graphs and plot your graph within the R window
}

# Challenge question D
Challenge_D <- function() {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Challenge question E
Challenge_E <- function() {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Challenge question F
Challenge_F <- function() {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Challenge question G should be written in a separate file that has no dependencies on any functions here.
