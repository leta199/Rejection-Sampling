# Rejection Sampling

Also know as the "accept- reject" mehod is a way of generating samples of data from a complex probability function such as gamma functions. Just like we can generate points from a uniform distribution in R, using this method: we can generate points from any defined funtions whereby the points follow the probabilistic nature of said funtion. We can then use  use this as synthetic data that followd the compled distribution in: Monte Carlo simulations, fine tuning machine learning models and much more.  

*Statistics is fun!*

We will use R to generate data from the following gamma function and overlay the probability density function to show that the data follows the gamma function when x >= 5

   <img width="340" height="77" alt="Image" src="https://github.com/user-attachments/assets/1af3f8ce-0295-40cd-904f-05885e4c2758" />

This project will cover:

- How to define and graph a target probability density function.
- How to define proposal probability density function..

 
## HOW IT'S MADE 
Languages used: R (version 4.5.1)    
Environment: RStudio  

[![Language: R](https://img.shields.io/badge/Language-R-276DC3.svg?style=flat-square)](https://www.r-project.org/)
[![Built with RStudio](https://img.shields.io/badge/IDE-RStudio-75AADB?style=for‐the‐badge&logo=rstudio&logoColor=white)](https://www.rstudio.com/)
![Status](https://img.shields.io/badge/Status-Completed-lightgrey)

## METHODS AND TECHNIQUES  
For this rejection sampling we will strat of by defining and graphing our traget pdf.

**Target probability denisty function**
This is the gamma function we must sample from where x >= 5.  
`target_pdf(x)`  
Is the name of this function graphed as: 

 ## PROJECT STRUCTURE      
|[Simulation- Monte Carlo Integration](https://github.com/leta199/Monte-Carlo-Integration/blob/main/Integration%20by%20simulation.r)  
|├── [Rejection sampling R script](https://github.com/leta199/Rejection-Sampling/blob/main/Rejection%20sampling.r)   
|└──[README](https://github.com/leta199/Simulation-Monte-Carlo-Integration/blob/main/README.md)
  
## AUTHORS   
[leta199](https://github.com/leta199)  
