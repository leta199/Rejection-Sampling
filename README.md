# Monte-Carlo-Integration
Monte Carlo integration allows us to use simulation to make stochastic approximations of functions that do not have closed form solutions when integrated.

We will use both Monte Carlo and Inverse transform to approximate the area of a circle of radius "r" with area "Y".   
Radius "r" is distributed on a uniformly on [1,4].
We will try to find the expected value of "Y" (our area). 

This project will cover:

- Comparing Monte Carlo to Inverse transform methods.
- Approximate the expected value of Area of a circle.
- Plotting histogram of Inverse method vs Line graph of theoretical probability density function.
 
## HOW IT'S MADE 
Languages used: R (version 4.5.1)    
Environment: RStudio  

[![Language: R](https://img.shields.io/badge/Language-R-276DC3.svg?style=flat-square)](https://www.r-project.org/)
[![Built with RStudio](https://img.shields.io/badge/IDE-RStudio-75AADB?style=for‐the‐badge&logo=rstudio&logoColor=white)](https://www.rstudio.com/)
![Status](https://img.shields.io/badge/Status-Completed-lightgrey)

## METHODS AND TECHNIQUES  
**Monte Carlo Method**
`sim_circle()` - We begin by defining a funcion that we will call to approximate the area of our circle with this method.     
- Define our set seed to allow for reproducibility.
- Set up 10,000 runs of the simulation.
- Randomly generate value of "r" from a uniform distribution from 1 to 4 and save to a list.
- Find the mean of the area from the generated.

  **Inverse CDF Method**
  `sim_circle_2()` - For this method was also also set our seed, number of trials.
  - Create a list of values "u" from a unifrom [0,1] distribution.
  - Calculate radii "r" using samples from the uniform distribution.
  - Store list of areas calculated from the radii "r" in the object "areas".
  
 ## VISUALISING SIMULATION 
We can compare the histogram and line graph of our generated areas and compare them to the actual probability density function of areas.

<img width="1058" height="838" alt="Image" src="https://github.com/user-attachments/assets/9dbe6cb9-3ddf-48e4-a0b1-102d9ea89575" />

 **Histogram** - shows us the density i.e proportion of total each bucket of ares appears with the bucket of area 5-10 beaing the most prevalent.  
 **Line graph** - creates a probability density of our areas following the simulated sample data.
 
 ## PROJECT STRUCTURE      
|[Simulation- Inverse Transform](https://github.com/leta199/Simulation-Random-Walks)  
|├── [Inverse Transform Method R script](https://github.com/leta199/Simulation-Inverse-Transform/blob/main/Inverse%20Transform%20Method.r)   
|└──[README](https://github.com/leta199/Simulation-Inverse-Transform/blob/main/README.md)
  
## AUTHORS   
[leta199](https://github.com/leta199)  
