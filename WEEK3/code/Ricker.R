#!/usr/bin/env Rscript

# Author: Y_Sun ys219@ic.ac.uk
# Script: Ricker.R
# Desc: practical with ricker model
# Arguments: 0
# Input:Rscript Ricker.R
# Output: printed output in r terminal
# Date: Oct 2019


Ricker <- function(N0=1, r=1, K=10, generations=50)
{
  # Runs a simulation of the Ricker model, parental generation have 1 individual, 
  #growth rate is 1, capacity og the environment is 10, run for 50 generations
  # Returns a vector of length generations
  
  N <- rep(NA, generations)    # Creates a vector of NA,with number of generations elements
  
  N[1] <- N0#set the population of the first generation
  for (t in 2:generations)#then add the N for following generations
  {
    N[t] <- N[t-1] * exp(r*(1.0-(N[t-1]/K)))
  }
  return (N)
}

plot(Ricker(generations=10), type="l")
