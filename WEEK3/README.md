CMEECoursework WEEK3
==
This directory includes my code, data, results of exercises and practical in CMEE week3


## Contents:

### `07 Biological Computing R`
### `08 Data management, exploration and visualization`

### [**code**](https://github.com/ys219/CMEECoursework/tree/master/WEEK3/code)

#### Practicals:

##### `TreeHeight.R` 

This first defined a function that can calculate the tree height from degree of sun light and the distance, then imported the extermanl data worked out the tree heights then export the data to a csv file.



##### `Ricker.R`

This has written ricker model into functions and simulate the generations and work out the data

##### `Vectorize2.R`

use the vectorization rather than another loop to input data to ricker model. Then compare the speed  of using loops and vectorizations

##### `TAutoCorr.R`

This script work out the correlation coefficient of temperature between successive year, then randomized the data by 10000times and work out correlation coefficient. Finally compare how many of them are greater than the actual one, which is the rough p value.

##### `TAutoCorr.tex`

the latex file that can complie a pdf for Autocorrelation results. 

##### `DataWrangTidy.R`

Wrang the data from DataWrang.R with the function in package dplyr, and achieve same outcome.

##### `PP_Lattice.R`

This script load the dataframe and draw density plot of predator, prey, prey/ predator size ration, and save them  into pdfs, also used tapply function to work out mean and median and output to a csv file. 


##### `PP_Regress.R`

use ggplot functions to work on the ppredator prey mass data, it is draw by the feeding type in seperate plotss and life stages by colours. and export the plot as a pdf file.

Then it extracted the slope, intercept, fstatistics, r square, and p value from the linear model, and export them to a csv file.

##### `GPDD_Data.R`

this script generate a map and plotted points of GPDD data on the map



#### Exercises:

##### `basic_io.R`

exercises of fundimental r grammar read and write csv functions

##### `control_flow.R`

exercises of control flow function in r language

##### `break.R`

exercise of adding break point in a loop, so it allows jump out of the loop or cease the process

##### `next.R`

exercise a putting next in loop, which is analogy to pass in python(?)


##### `boilerplate.R`

exerciise of defining funciton in the r script.

##### `Vectorize1.R`

Use the vectorization rather than loop, then compare the system time of two ways 

##### `Preallocation.R`

it tells different ways to add vectors into a data frame, and also illustrate the meomry space.

##### `apply.R`

use apply function to work out mean, median and variance from certain row.

##### `apply2.R`

use apply function on matrix, and work out the calculations

##### `sample.R`

use apply and lappy function with loops, vectorization and preallocation, then campare which gives the quickest outcome.

##### `try.R`

A debugging exercise in R

##### `browser.R`

another debugging method in R and open browser to debug it.

##### `DataWrang.R`

Use melt function to rearrange the data frame for stats

##### `Girko.R`

An exercise to practice plot with ggplot and export as a pdf file.

##### `PlotLin.R`

An exercise that plot the regression line on scatter plot and export the plot as a pdf file.

##### `MyBars.R`

Draw bars with ggplot function and annotation the plot, then save the plots to a pdf file