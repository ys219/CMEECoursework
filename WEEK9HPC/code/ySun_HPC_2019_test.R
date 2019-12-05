# CMEE 2019 HPC excercises R code HPC run code proforma

rm(list=ls()) # good practice 
# setwd("/home/yige/Documents/CMEECoursework/WEEK9/code/")
source("ySun_HPC_2019_main.R")
# it should take a faction of a second to source your file
# if it takes longer you're using the main file to do actual simulations
# it should be used only for defining functions that will be useful for your cluster run and which will be marked automatically

# do what you like here to test your functions (this won't be marked)
# for example
species_richness(c(1,4,4,5,1,6,1))
# should return 4 when you've written the function correctly for question 1

# you may also like to use this file for playing around and debugging
# but please make sure it's all tidied up by the time it's made its way into the main.R file or other files.

## Q1:
species_richness(c(1,4,4,5,1,6,1))
## Q2:
init_community_max(10)
## Q3:
init_community_min(3)
## Q4:
choose_two(10)
## Q5:
neutral_step(c(13,56,24,78,65,28))
## Q6:
neutral_generation(init_community_max(9))
## Q7:
neutral_time_series(init_community_max(9), 20)
## Q8:
question_8()
## Q9:
neutral_step_speciation(c(13,56,24,78,65,28),0.2)
## Q10:
neutral_generation_speciation(c(13,56,24,78,65,28),0.2)
## Q11:
neutral_time_series_speciation(c(13,56,24,78,65,28),0.2,20)
## Q12:
question_12()
## Q13:
species_abundance(c(1,5,3,6,5,6,1,1))
## Q14:
octaves(c(100,64,63,5,4,3,2,2,1,1,1,1))
## Q15:
sum_vect(c(1,0,6),c(1,3,2,4,5))
## Q16:
question_16()
## Q17:
cluster_run(speciation_rate = 0.1, size = 100, wall_time = 0.5, 
            interval_rich = 1, interval_oct = 10, burn_in_generations = 200,
            output_file_name = "../results/my_test_file_1.rda")
## Q23:
chaos_game()
## Q24:
plot(x=0,y=0,xlim = c(-5,5), ylim = c(-2,2))
turtle(c(0,0),direction = pi/3,length = 1)

##Q25:
plot(x=0,y=0,xlim = c(-5,5), ylim = c(-2,2))
elbow(c(0,0),direction = pi/3,length = 1)

#Q26:
plot(x=0,y=0,xlim = c(0,2.5), ylim = c(-1.5,1.5),cex = 0.1, pch = 16)
spiral(c(0,0),direction = pi/3,length = 1)

#Q27:
draw_spiral()

##Q28:
draw_tree()

##Q29:
draw_fern()

##Q30:
draw_fern2()
