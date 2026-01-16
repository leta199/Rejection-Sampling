# Rejection Sampling

Also know as the "accept- reject" method is a way of generating samples of data from a complex probability function such as gamma functions. Just like we can generate points from a uniform distribution in R, using this method: we can generate points from any defined funtions whereby the points follow the probabilistic nature of said funtion. We can then use  use this as synthetic data that followd the compled distribution in: Monte Carlo simulations, fine tuning machine learning models and much more.  

*Statistics is fun!*

We will use R to generate data from the following gamma function and overlay the probability density function to show that the data follows the gamma function when x >= 5

   <img width="340" height="77" alt="Image" src="https://github.com/user-attachments/assets/1af3f8ce-0295-40cd-904f-05885e4c2758" />

This project will cover:

- How to define and graph a target probability density function.
- How to define proposal probability density function.

 
## HOW IT'S MADE 
Languages used: R (version 4.5.1)    
Environment: RStudio  

[![Language: R](https://img.shields.io/badge/Language-R-276DC3.svg?style=flat-square)](https://www.r-project.org/)
[![Built with RStudio](https://img.shields.io/badge/IDE-RStudio-75AADB?style=for‐the‐badge&logo=rstudio&logoColor=white)](https://www.rstudio.com/)
![Status](https://img.shields.io/badge/Status-Completed-lightgrey)

## METHODS AND TECHNIQUES  
For this rejection sampling we will strat of by defining and graphing our traget pdf.

**Target probability density function**  
This is the gamma function we must sample from where x >= 5.  

`target_pdf(x)`  
Is the name of this function graphed as:   
<img width="1067" height="837" alt="Image" src="https://github.com/user-attachments/assets/33543cf6-8fbd-4598-a47b-1b77b7ef988b" />

**Proposal probability density function**  
This is a known probability distribution that we can easily sample from e.g in R. It must follow the following criteria:  
1) Cover the target pdf i.e proposal_pdf(x) >= target_pdf(x) for any x.
2) Be in the the general shape of the target.

For this target proposal I seleced an exponential distribution with lambda = 1 translated by + 5. 

`proposal_pdf(x)`  
Function we will use grpahed as: 
<img width="1195" height="838" alt="Image" src="https://github.com/user-attachments/assets/9c51eb61-7bc2-485c-8a84-bdfa6c0b17b3" />

**Rejection Sampling**
Once we have defined the function as number generators we can then use the method of rejection sampling to accept or reject generated value. 

`sim_gamma()`   
Is the function we will use for our reject or accept method. We begin by defining: 
1) The seed for general reprodicibility.
2) Number of samples we want to generate (5000) as `n`.
3) `sample_y` is the vector containing n many allowable values.
4) `total_samples` is an empty list that will store all the generated values.
5) Number of total sample we generated as `number`. 

*While loop*  
This loop allows for data generation so long as a condition is met. In this case the criteria would be:  
While the count of values in sample_y is less than 5000:
- Generate a value from our proposal `y`.
- Sample a value from a uniform distribution from 0 to 1 called `u`.
- Add the generated value `y` to our total_sample empty list and increase the total number of values generated in `number`.
- Calculate `acceotance_rate` using the formula (5000/ number of total value) * 100. 
- Compare the value  `u` to the value of target_pdf(x)/proposal_pdf(x).
- If u <  target_pdf(x)/proposal_pdf(x) add 1 to the count and add that value to  `sample_y`.
  

target_pdf(x)/proposal_pdf(x) - acts as a upper bound on the probability of acceptance, and if the value of u is greater than it, reject the value as a valid sample. 

Once we have generated 5000 samples we will return `sample_y`.

**Visualisations**
We will visualise the output from `sim_gamma()` with a histogram and overlay the continuous probability curve over it. Keep in mind freq = FALSE to represent the density of each bin and therefore toal areas of all bins toegther is 1 which is the sum of the sum pf all probabilites of events/ outcomes in a probabilty denisty function. 

<img width="1313" height="830" alt="Image" src="https://github.com/user-attachments/assets/6e09ab04-14c9-465c-856a-f4d6cee3b913" />

As we can see the bar chart lines up roughly with our continuous curve of the target probability density function proving that we have kept the original distribution with our 5000 samples.


 ## PROJECT STRUCTURE      
|[Simulation- Rejection Sampling](https://github.com/leta199/Monte-Carlo-Integration/blob/main/Integration%20by%20simulation.r)  
|├── [Rejection sampling R script](https://github.com/leta199/Rejection-Sampling/blob/main/Rejection%20sampling.r)   
|└──[README](https://github.com/leta199/Simulation-Monte-Carlo-Integration/blob/main/README.md)

## USEFUL RESOURCES 
The textbook "Probability with applications and R"  by Dr. Wagaman and Dr. Dobrow was very helpful in many of my endevours.  
[Rejection Sampling: Sampling from ‘difficult’ distributions](https://medium.com/@roshmitadey/rejection-sampling-sampling-from-difficult-distributions-dbd17742a919) - was a website that lays down the basics of rejection sampling.

## AUTHORS   
[leta199](https://github.com/leta199)  
