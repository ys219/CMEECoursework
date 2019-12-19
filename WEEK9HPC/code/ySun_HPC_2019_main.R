# CMEE 2019 HPC excercises R code main proforma
# you don't HAVE to use this but it will be very helpful.  If you opt to write everything yourself from scratch please ensure you use EXACTLY the same function and parameter names and beware that you may loose marks if it doesn't work properly because of not using the proforma.

name <- "Yige Sun"
preferred_name <- "Yige"
email <- "ys219@ic.ac.uk"
username <- "ys219"
personal_speciation_rate <- 0.005849 # will be assigned to each person individually in class and should be between 0.002 and 0.007

# Question 1
species_richness <- function(community){
  richness = length(unique(community))# get rid of the repeats and measure the length
  return(richness)
}

# Question 2
init_community_max <- function(size){
  initmax = seq(1,size,by = 1)# from 1 to size
  return(initmax)
}

# Question 3
init_community_min <- function(size){
  initmin = rep(1,size)# repeat one spp identity for size times
  return(initmin)
}

# Question 4
choose_two <- function(max_value){
  sample(max_value,2,replace = FALSE)# randomly choose two from the vector
}

# Question 5
neutral_step <- function(community){
  sampling = choose_two(length(community))## randomly choose 2
  community=replace(community,sampling[1],community[sampling[2]])## kill one and regenerate one
  return(community)
}

# Question 6
neutral_generation <- function(community){
  steps = length(community)/2
  steps = sample(c(ceiling(steps),floor(steps)),1)## equally likely goes for 1 or 0 when get a 0.5
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
    myv = c(myv,richness)# combind the neutral generation and work out richness over generations
  }
  return(myv)
}

# Question 8
question_8 <- function(community=100,duration=200) {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot(neutral_time_series(init_community_max(community),duration),
       xlab = "Generation",
       ylab = "Species richness",
       type = "l")
  return("It will always converge to species richness = 1, if we wait long enough. That is because no new species would come up (i.e. no speciation) in this system,the species richness would keep declining until it reaches 1.")
}

# Question 9
neutral_step_speciation <- function(community,speciation_rate)  {
  rate = runif(1,min = 0, max = 1)# generate a number to decide fall into speciation rate or not 
  
  if (rate <= speciation_rate){
    
    newspp = max(community)+1# generate a brand new spp id
    sampling = sample(1:length(community),1)#choose an individual to die
    community[sampling] = newspp# replace with new spp
    
  } else {
    community= neutral_step(community)# no speciation occur
    
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
    richness=species_richness(community)# record spp richness
    myv = c(myv,richness)
  }
  return(myv)
}

# Question 12
question_12 <- function(community = 100, speciation_rate = 0.1, duration = 200)  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
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
  return("Regardless the starting species richness, if the generations are long enough, species richness would stay in a range and flatuate. Looks like an quilibrium status. All the lines on the plot are converged to it. 
         The speed of species extinction getting more and more stable(as Q8 shows) over many generationd. We set the speiation rate(i.e. gaurenteed it's steady), therefore, speed of speciation and extinction would able to be similar, which is shown as a dynamic equilibrium in species richness.")
}

# Question 13
species_abundance <- function(community)  {
  community = as.vector(sort(table(community),decreasing = TRUE))## table return length of each spp, sort() sort it in order, finally convert it to vector
  return(community)
}

# Question 14
octaves <- function(abundance_vector) {
  ab = log(abundance_vector,2)## log the input number by 2
  ab = floor(ab)+1 ## convert the logged number to bin number(get rid of dicimals) 
  bin = tabulate(ab)## put numbers into bins
  return(bin)
}


# Question 15
sum_vect <- function(x, y) {
  if (length(x) > length(y)){## look at which is bigger
    
    y = c(y,rep(0,length(x)-length(y)))## add 0s to the short one
    sum= x+y## add up two vectors
    
  } else if(length(x) < length(y)) {
    
    x = c(x,rep(0,length(y)-length(x)))
    sum = x+y
    
  } else {# if equally long, just add
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
  graphics.off()
  community = init_community_max(communitysize)
  community_min = init_community_min(communitysize)
  
  octsum = c()
  octsum_min = c()
  
  for (i in 1:duration){
    community = neutral_generation_speciation(community, speciation_rate)
    abundance = species_abundance(community)
    oct = octaves(abundance)
    
    community_min = neutral_generation_speciation(community_min, speciation_rate)
    abundance_min = species_abundance(community_min)
    oct_min = octaves(abundance_min)
    if (i > burn_in  & i%%20 == 0){
      octsum = sum_vect(octsum, oct)
      octsum_min = sum_vect(octsum_min, oct_min)
      
    }
  }
  octmean = octsum/100
  octmean_min = octsum_min/100
  lightblue = rgb(red=0.35,green=0.7,blue=0.9, alpha = 0.6)
  vermilion = rgb(red=0.8,green=0.4,blue=0, alpha = 0.3)
  par(mfrow = c(1,2))
  barplot(octmean,
          names.arg =  seq(1:length(octmean)),
          xlab = "bin for abundance ",
          ylab = "number of species", 
          ylim = c(0,10),
          col = lightblue,
          main = "With maximum spp richness"
          )
  barplot(octmean_min,
          names.arg = seq(1:length(octmean_min)),
          xlab = "bin for abundance",
          ylab = "number of species",
          ylim = c(0,10),
          col = vermilion,
          main = "With minimum spp richness"
  )

  return("Initial condition doesn't obviously affect the outcomes. 
         To maintain the species richness dynamic equilibrium, many of sepceis would be in risk of extinction, to stablise the speed of extinction.
         Actually, all the species are equally likely to be abundant and low in abundance. The new species have only one individual in the population when it generated,
         which makes it less likely to be selected to die and give it some times to replicate itselves. 
         But more dominant species are more likely to lost its members.
         That makes us observe, over long enough generations, there keep have a fair amount of species in low abundance, regardless the initial species richness")
}

# Question 17
cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name)  {
  ##generate data and create something to store it :
  community = init_community_min(size)
  generation = 0
  time_series = c()
  octlist = list()
  start_time = proc.time()[3]
  ## simulations within the wall_time length:
  while((proc.time()[3] - start_time)/60 <  wall_time){
    community = neutral_generation_speciation(community, speciation_rate)
    generation = generation + 1## generation counter
    ## burn in time :
    if (generation < burn_in_generations & generation %% interval_rich == 0 ){
      time_series = c(time_series, species_richness(community))}## record sppecies richness
    ## intervals the recoed the octaarves:
    if (generation %% interval_oct ==0){## record oct every interval
      abundance = species_abundance(community)#get abundance
      oct = octaves(abundance)#put abundance to octaves
      octlist[[length(octlist)+1]] = oct}# append the oct to list
  }
  thetime = paste(proc.time()[3]-start_time, "seconds")## how long its been run
  save(time_series, octlist, community, thetime,
       speciation_rate, size, wall_time, interval_rich, interval_oct,burn_in_generations,
       file = output_file_name)## save the data
}

# Questions 18 and 19 involve writing code elsewhere to run your simulations on the cluster

# Question 20 
process_cluster_results <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  setwd("../results/")## directory where results stored
  results = list.files(pattern = "cluster_run_seed_*")##get the files names
  ## vector for different sizes
  size500 = c()
  size1000 = c()
  size2500 = c()
  size5000 = c()
  
  count_len = c()
  for (i in 1:length(results)){
    filename = paste0("cluster_run_seed_",i,".rda")
    load(filename)# load the results
    tmp = c()## a vector to add 
    
    non_burn = burn_in_generations/interval_oct## ready to get rid of burn in 
    for (j in non_burn : length(octlist)){
      tmp = sum_vect(tmp,octlist[[j]])# sum up and average the current oct
    }
    tmp = tmp/length(octlist)
    if(size == 500){
      size500 = sum_vect(size500,tmp)# add to vector for different size
      count_len = c(count_len,500)
    }
    if(size == 1000){
      size1000 = sum_vect(size1000,tmp)
      count_len = c(count_len,1000)
    }
    if(size == 2500){
      size2500 = sum_vect(size2500,tmp)
      count_len = c(count_len,2500)
    }
    if(size == 5000){
      size5000 = sum_vect(size5000,tmp)
      count_len = c(count_len,5000)
    }
    
  }
  
  count_len = as.vector(table(count_len))## work out length for each oct
  #work out mean
  size500 = size500/count_len[1]
  size1000 = size1000/count_len[2]
  size2500 = size2500/count_len[3]
  size5000 = size5000/count_len[4]
  
  par(mfrow = c(2,2))
  barplot(size500, main = "Mean spp abundance octaves, size = 500",ylim = c(0,max(size500)+1),names.arg =  seq(1:length(size500)),xlab = "bin for abundance", ylab = "number of species")
  barplot(size1000, main = "Mean spp abundance octaves, size = 1000",ylim = c(0,max(size1000)+1),names.arg =  seq(1:length(size1000)),xlab = "bin for abundance", ylab = "number of species")
  barplot(size2500, main = "Mean spp abundance octaves, size = 2500",ylim = c(0,max(size2500)+1),names.arg =  seq(1:length(size2500)),xlab = "bin for abundance", ylab = "number of species")
  barplot(size5000, main = "Mean spp abundance octaves, size = 5000",ylim = c(0,max(size5000)+1),names.arg =  seq(1:length(size5000)),xlab = "bin for abundance", ylab = "number of species")
  
  combined_results <- list(size500,size1000,size2500,size5000) #create your list output here to return
  save(combined_results, file = "/home/yige/Documents/CMEECoursework/WEEK9HPC/code/ys219_cluster_results.rda")
  setwd("../code/")
  return(combined_results)
}


# Question 21
question_21 <- function()  {
  return( list(log(8,3),"When width increase by 3, size (in 2D)increase 8 blocks, therefore demension increase log(8)/log(3)"))
}

# Question 22
question_22 <- function()  {
  return(list(log(20,3),"When width increase by 3, size (in 3D) increase 20 blocks, therefore demension increase log(20)/log(3)"))
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

  return("The dots form fractal triangle, more dots been plotted, the triangle looks denser")
}

# Question 24
turtle <- function(start_position, direction, length)  {## plot a line with set ength and angle
  next_point = c(start_position[1]+length*cos(direction),start_position[2]+length*sin(direction))
  lines(x = c(start_position[1],next_point[1]), y = c(start_position[2],next_point[2]))
  return(next_point) # you should return your endpoint here.
}

# Question 25
elbow <- function(start_position, direction, length)  {
  next_point  = turtle(start_position, direction, length)
  start_position = next_point
  direction = direction-pi/4 # turn the direction
  length = 0.95*length # get it shorter
  next_point  = turtle(start_position, direction , length)
  
}

# Question 26
spiral <- function(start_position, direction, length)  {
  next_point  = turtle(start_position, direction, length)
  if (length <= 2e-30){
    return("a sprial is formed, that's because the lines keep turning to same direction and continously reduce in length. A threshold need to be setted, as length couldn't go infinitly small")
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
tree <- function(start_position, direction, length, e = 0.05)  {
  next_point  = turtle(start_position, direction, length)## get to next point
  if (length >= e){
    tree(next_point, direction-pi/4 , 0.65*length)## turn left
    tree(next_point, direction+pi/4 , 0.65*length)## turn right
  }

}
  
draw_tree <- function(start_position= c(10,-10), direction = pi/2, length = 5, e = 0.05)  {
  graphics.off()
  plot(x=10,y=10,xlim = c(0,20), ylim = c(-10,5),cex = 0.1, pch = 16)
  tree(start_position,direction = direction,length = length, e = e)
  # clear any existing graphs and plot your graph within the R window
}

# Question 29
fern <- function(start_position, direction, length)  {
  next_point  = turtle(start_position, direction, length)
  if (length >= 0.05){
    fern(next_point, direction+pi/4 , 0.38*length)## turn 45 degree
    fern(next_point, direction , 0.87*length)## straight up
  }
}
draw_fern <- function()  {
  graphics.off()
  plot(x=10,y=10,xlim = c(0,20), ylim = c(-10,30),cex = 0.1, pch = 16, xlab = "", ylab = "")
  fern(c(10,-10),direction = pi/2,length = 5)
  # clear any existing graphs and plot your graph within the R window
}

# Question 30
fern2 <- function(start_position= c(10,-10), direction = pi/2, length = 5, dir = 1, e = 0.05)  {
  next_point  = turtle(start_position, direction, length)
  if (length >= e){
    fern2(next_point, direction+dir*pi/4 , 0.38*length, dir)
    dir = -1*dir## alter the direction when going straight 
    fern2(next_point, direction , 0.87*length, dir)
  }
}

draw_fern2 <- function(start_position= c(10,-10), direction = pi/2, length = 5, dir = 1, e = 0.05)  {
  graphics.off() 
  plot(x=10,y=10,xlim = c(0,20), ylim = c(-10,30),cex = 0.1, pch = 16,xlab = "",ylab = "")
  fern2(start_position= start_position, direction = direction, length = length, dir = dir , e = e)
  # clear any existing graphs and plot your graph within the R window
}

# Challenge questions - these are optional, substantially harder, and a maximum of 16% is available for doing them.  

# Challenge question A
Challenge_A <- function(communitysize = 100 , speciation_rate = 0.1, duration = 200, repeats= 50) {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  ######for maximum community
  
  ##generate communities with max&min spp richness
  max_community = init_community_max(communitysize)
  min_community = init_community_min(communitysize)
  ## loop to work out richness over generations, reapt it multiple times and put to a matrix
  max_richness = matrix(nrow = 0, ncol = duration)
  min_richness = matrix(nrow = 0, ncol = duration)
  repeat{
    max_richness = rbind(max_richness,neutral_time_series_speciation(community = max_community, speciation_rate = speciation_rate, duration = duration))
    min_richness = rbind(min_richness,neutral_time_series_speciation(community = min_community, speciation_rate = speciation_rate, duration = duration))
    
    if(nrow(max_richness) == repeats)break
  }
  ## work out the mean richness value for each generation
  
  max_mean_richness = c()
  max_ci_left = c()
  max_ci_right = c()
  
  min_mean_richness = c()
  min_ci_right = c()
  min_ci_left = c()
  
  for (i in 1:duration) {
    max_mean = mean(max_richness[,i])
    max_mean_richness = c(max_mean_richness,max_mean)
    error = qnorm(0.972)*sd(max_richness[,i])/sqrt(ncol(max_richness)) ##confidence interval: https://www.cyclismo.org/tutorial/R/confidence.html
    max_ci_right = c(max_ci_right,max_mean+error)
    max_ci_left = c(max_ci_left,max_mean-error)
    
    min_mean = mean(min_richness[,i])
    min_mean_richness = c(min_mean_richness,min_mean)
    error = qnorm(0.972)*sd(min_richness[,i])/sqrt(ncol(min_richness)) 
    min_ci_right = c(min_ci_right,min_mean+error)
    min_ci_left = c(min_ci_left,min_mean-error)
  }
  
  ## estimate burn in generation
  # i take the max value of min_community right CI & min value of max_community left CI as a range,
  # richness values within this range are considered as in the burnin 

  for (i in 1:duration){
    if (max_mean_richness[i] < max(min_ci_right) & min_mean_richness[i] > min(max_ci_left)) {
      est_burn_in = i
      break}
  }
 
  ####plot the mean and confident intervals
  lightblue = rgb(red=0.35,green=0.7,blue=0.9, alpha = 0.6)
  vermilion = rgb(red=0.8,green=0.4,blue=0, alpha = 0.6)
  
  
  plot(max_mean_richness,type = "l", col = "blue", ylim = c(0,100),xlab = "Generations", ylab = "Mean species richness")
  polygon(c(seq(duration), rev(seq(duration))),c(max_ci_right, rev(max_ci_left)), col = lightblue, border = FALSE)
  lines(min_mean_richness,col = "red")
  polygon(c(seq(duration), rev(seq(duration))),c(min_ci_right, rev(min_ci_left)), col = vermilion, border = FALSE)
  abline(v= est_burn_in,lty = 2, col = "grey60")
  legend(100,100, legend = c("Max init species richness","Min init species richness", paste0("estimate burn in =",est_burn_in)), col = c("blue","red", "grey60"), lty = c(1,1,2),bty = "n",cex = rep(0.8,3))
  return(NULL)
}

# Challenge question B
Challenge_B <- function(communitysize = 100 , speciation_rate = personal_speciation_rate, duration = 100, repeats= 50) {
  # clear any existing graphs and plot your graph within the R window
  try(dev.off(), silent = TRUE)
  message("Chanllenge B started, will take about 4 min")
  sta = proc.time()[3]
  ## make a matrix with communities that have whole range of speccies richness
  communities_matrix = matrix(nrow = communitysize, ncol = communitysize)
  # print("generating communites with whole range of richness")
  for (i in 1:communitysize){## go through each row
    ## make a community vector that each individual are equally likely to take any identity, but ensure the different spp sichness with first few positions
    communities_matrix[i,] = c(seq(1:i),sample(1:i, size = ncol(communities_matrix)-i, replace = TRUE))
    # print(paste("community, richness =",i,"complete"))
  }
  message("communities generated")
    
  ## generate the average time series(richness) data
  mean_richness_matrix = matrix(nrow = communitysize , ncol = duration +1)## ncol = duration+1 is generate a colum for initial condition
  for (j in 1:nrow(communities_matrix)){
    sum_richness = c()
    count = 0
    while(count <= repeats){## generate richness multiple times, and add them up
      sum_richness = sum_vect(sum_richness,neutral_time_series_speciation(community = communities_matrix[j,], speciation_rate = speciation_rate, duration = duration))
      count = count+1
    }
    mean_richness_matrix[j,] = sum_richness/repeats
    message(paste("Mean richness for community",j, "completed"))
  }
  message("start plotting")
  plot(x = 0, y = 0, xlim = c(0,duration+2), ylim = c(0,communitysize+2),pty = 16, col = "white",cex = 0.1,
       xlab = "Generation", ylab = "Mean Species Richness", main = "Mean Richness for Whole range of Starting Species Richness")
  for (k in 1:nrow(mean_richness_matrix)){
    lines(mean_richness_matrix[k,],col = k)
  }
  message("chanllenge B completed"," took ",(proc.time()[3]-sta)/60,"min")
}

# Challenge question C
Challenge_C <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  setwd("/home/yige/Documents/CMEECoursework/WEEK9HPC/results/")
  results = list.files(pattern = "cluster_run_seed_*")
  
  sum500 = c()
  sum1000 = c()
  sum2500 = c()
  sum5000 = c()
  
  count_len = c()
  for (i in 1:length(results)){
    filename = paste0("cluster_run_seed_",i,".rda")
    load(filename)

    if(size == 500){
      sum500 = sum_vect(sum500,time_series)
      count_len = c(count_len,500)
      burn_in_500 = burn_in_generations
    }
    if(size == 1000){
      sum1000 = sum_vect(sum1000,time_series)
      count_len = c(count_len,1000)
      burn_in_1000 = burn_in_generations
    }
    if(size == 2500){
      sum2500 = sum_vect(sum2500,time_series)
      count_len = c(count_len,2500)
      burn_in_2500 = burn_in_generations
    }
    if(size == 5000){
      sum5000 = sum_vect(sum5000,time_series)
      count_len = c(count_len,5000)
      burn_in_5000 = burn_in_generations
    }
  }
  
  count_len = as.vector(table(count_len))
  mean500 = sum500/count_len[1]
  mean1000 = sum1000/count_len[2]
  mean2500 = sum2500/count_len[3]
  mean5000 = sum5000/count_len[4]

  plot(x = 0, y = 0, xlim = c(0,min(length(mean500),length(mean1000),length(mean2500),length(mean5000))+2), ylim = c(0, max(mean500,mean1000,mean2500,mean5000)+2),pty = 16, col = "white",cex = 0.1,
       xlab = "Generation", ylab = "Mean Species Richness", main = "Mean Richness for different community sizes")
  lines(mean500, col = "#009E73")
  lines(mean1000,col =  "#0072B2")
  lines(mean2500,col =  "#D55E00")
  lines(mean5000,col = "#CC79A7")
  legend("bottomright",
         legend = c("size = 500","size = 1000","size = 2500","size = 5000"),
         col = c("#009E73", "#0072B2", "#D55E00", "#CC79A7"),
         cex = 0.8, lty = 1)
  

 #create your list output here to return
  setwd("/home/yige/Documents/CMEECoursework/WEEK9HPC/code/")
  
}

# Challenge question D
Challenge_D <- function() {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Challenge question E
Challenge_E <- function() {
  graphics.off()
  par(mfrow = c(2,2))
  # clear any existing graphs and plot your graph within the R window
  ##draw tirangle
  dots = list(c(0,0),c(3,4),c(4,1))
  X = c(0,0)
  plot(x=X[1], y=X[2], cex = 0.5 , pch = 16 , xlim = c(-1,5), ylim = c(-1,5))
  
  sta = proc.time()[3]
  while(proc.time()[3]-sta <10){
    choice = sample(1:3,1)
    X = (dots[[choice]]+X)/2
    points(x=X[1], y=X[2], cex = 0.5 , pch = 16)
  }
  
  ## draw equilateral triangle
  dots_eq = list(c(0,0),c(4,0),c(2,2*sqrt(3)))
  X = c(0,0)
  plot(x=X[1], y=X[2], cex = 0.5 , pch = 16 , xlim = c(-1,5), ylim = c(-1,5))
  sta = proc.time()[3]
  while(proc.time()[3]-sta <8){
    choice = sample(1:3,1)
    X = (dots_eq[[choice]]+X)/2
    points(x=X[1], y=X[2], cex = 0.5 , pch = 16)
  }
    
    ## draw pentagon
    dots_pen = list(c(0,2),c(2,3),c(4,2),c(3,0),c(1,0))
    X = c(0,2)
    plot(x=X[1], y=X[2], cex = 0.5 , pch = 16 , xlim = c(-0.5,2), ylim = c(-0.5,1.5))
    
    sta = proc.time()[3]
    
    while(proc.time()[3]-sta <8){
      choice = sample(1:5,1)
      X = (dots_pen[[choice]]+X)/4
      points(x=X[1], y=X[2], cex = 0.5 , pch = 16)
    }
    
    ## draw square
    dots_ran = list(c(0,0),c(0,4),c(4,4),c(4,0))
    X = c(0,0)
    plot(x=X[1], y=X[2], cex = 0.5 , pch = 16 , xlim = c(-1,3), ylim = c(-1,3))
    sta = proc.time()[3]
    while(proc.time()[3]-sta <10){
      choice = sample(1:4,1)
      X = (dots_ran[[choice]]+X)/3
      points(x=X[1], y=X[2], cex = 0.5 , pch = 16)
    }
    return("Starting position wouldn't affect the graph, 
         (probably)because by moving halfway toward the three points(tip of triangle), it will keep approaching the three points 
         and eventually close enough and looks like strat from those points.")
}

# Challenge question F
Challenge_F <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot.new()# creat empty plot
  
  direction = c(4*pi/5,pi/2,pi/5)## staring direction for three trees
  col_set = matrix(data = c("#66CCFF","#00FFFF","#00CCFF","#6699FF","#3366CC","#9966FF"), ncol = 2, nrow = 3,byrow = T) ## colour matrix
  thresholds = c(0.02,0.009,0.005)## the thresholds
  legend_position = matrix(data = c(.2,.1,.5,.9,.7,.1), ncol = 2, nrow = 3, byrow = T)## text positions
  c = c("skyblue","blue","purple")## colour name for text 
  
  for (i in 1:3){# plot three trees with different thresholds, & colour
    sta = proc.time()[3]
    t = function(x=0.5,y=0.3,d=direction[i],l=0.15, s= 0.7, col, colour_set=col_set[i,],e = thresholds){
      a = x+l*cos(d)## next point x
      b = y+l*sin(d)## next point y
      color = colour_set## get the colout for current tree
      lines(c(x,a),c(y,b), col = color[col])## draw lines, each line get one of the 2 colours
      
      if(l>e[i]){## threshold
        t(a,b,d+pi/6,s*l,s,col=1)## turn left 30 degree, shorter by scale
        t(a,b,d-pi/20,s*l,s,col = 2)## turn right 9 degree, shorter by scale
      }
    }
    t()
    ### mirror image
    t = function(x=0.5,y=0.3,d=direction[i],l=0.15, s= 0.7, col, colour_set=col_set[i,], e=thresholds){
      a = x+l*cos(d)
      b = y+l*sin(d)
      color = colour_set
      lines(c(x,a),c(y,b), col = color[col])
      
      if(l>e[i]){
        t(a,b,d-pi/6,s*l,s,col=1,)
        t(a,b,d+pi/20,s*l,s,col = 2,)
        
      }
    }
    t()
    the_time = round(proc.time()[3]-sta,2)
    pos = list(x=legend_position[i,1],y = legend_position[i,2])
    text(pos,paste0(c[i]," tree, e=",thresholds[i], " \ntook ",the_time,"s to produce"),cex = 0.6)
    Sys.sleep(1)
  }
  
  return("When e(line threshold) is smaller, more lines would be drawn because. 
         Therefore would take longer time to produce the image")
}


## Challenge question G should be written in a separate file that has no dependencies on any functions here.