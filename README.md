# Rejection Sampling

Also know as the "accept - reject" method is a way of generating samples of data from a complex probability function. We will apply this method to solve problems in order to generate random variables. 
*Statistics is fun!*
This project will cover:

- How to define and graph a target probability density function.
- How to define proposal probability density function.
- Making a scaling factor for our problems


## HOW IT'S MADE 
Languages used: R (version 4.5.2)    
Environment: RStudio  

[![Language: R](https://img.shields.io/badge/Language-R-276DC3.svg?style=flat-square)](https://www.r-project.org/)
[![Built with RStudio](https://img.shields.io/badge/IDE-RStudio-75AADB?style=for‐the‐badge&logo=rstudio&logoColor=white)](https://www.rstudio.com/)
![Status](https://img.shields.io/badge/Status-Completed-lightgrey)


## METHODS AND TECHNIQUES  
This problem in rejection sampling will be to sample from: 

<img width="340" height="77" alt="Image" src="https://github.com/user-attachments/assets/1af3f8ce-0295-40cd-904f-05885e4c2758" />


**Target probability density function**  
This is the Gamma(2,1) function we must sample from where x >= 5.   
We are intested in the section after x>=5 to have a vlaid distribution 

`target_pdf(x)`     
<img width="762" height="514" alt="Image" src="https://github.com/user-attachments/assets/9b26809e-fdf3-4a03-8ab8-df2fb0ab6a0b" />


**Proposal probability density function**  
This is a known probability distribution that we can easily sample from e.g in R.   
It must follow the following criteria:  
 **i**  Cover the target pdf i.e there must be some M where:  M * proposal_pdf(x) >= target_pdf(x) for any x in the support. 

### **Exponential Distribution**   
Initially, I wanted to use an exponential distribution however I soon ran into a few problems.  
For this  proposal distribution, I seleced an exponential distribution with lambda = 1.  

We then have to find the scaling factor M so that we can fulfill condition 1 above. 
To find this value we used the logic in the Mathematics note here:  [Math Note exponential](https://github.com/leta199/Rejection-Sampling/blob/main/ExponentialProposal/Rejection_Sampling.pdf)  
After finding this scaling factor, we plotted the graph below: 


- We can see that comparatively, our Gamma(2,1) has a heaver tail than our Exponential(1) curve even after scaling.
- Our Exponential(1) is more convex than Gamma(2,1) therefore, our condition **i** above is not fullfilled. 

Even after generating the samples, we can see that the Exponential(1) does not work through **histrogram** : 


**QQ plot** of generated samples also shows that the generated samples do not fit the Gamma(2,1) distribution.


### **Cauchy Distribution**  
Cuachy distributions are calssically hevaier tailed than T or Normal or  distirbutions therefore, this was the second proposal to be used. 
Through the use of a Cauchy distribution Cauchy(1,1), we are able to fill condition *i* as shown by the graph below:

We can now continue to our rejection sampling step with our known scaling factor M
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
- Generate a value from our proposal called `y`.
- Sample a value from a uniform distribution from 0 to 1 called `u`.
- Add the generated value `y` to our `total_sample` empty vector and increase the total number of values generated in `number` by 1.
- Calculate `acceptance_rate` using the formula (5000/ number of total value) * 100. 
- Compare the value  `u` to the value of target_pdf(y)/proposal_pdf(y).
- If u <  target_pdf(x)/proposal_pdf(x) add 1 to the count and add that value to  `sample_y`.
  

target_pdf(x)/proposal_pdf(x) - acts as a upper bound on the probability of acceptance, and if the value of u is greater than it, reject the value as a valid sample. 

Once we have generated 5000 samples we will make a list that can return either the  `acceptance rate`  or our 5000 accepted samples in `sample_y`.

**Visualisations**  
We will visualise the output from `sim_gamma()` with a histogram and overlay the continuous probability curve over it. Keep in mind freq = FALSE to represent the density of each bin and therefore total areas of all bins together is 1 which is the sum of the sum pf all probabilites of events/ outcomes in a probabilty denisty function. 
As we can see the bar chart lines up roughly with our continuous curve of the target probability density function proving that we have kept the original distribution with our 5000 samples.

 ## PROJECT STRUCTURE      
|[Simulation- Rejection Sampling](https://github.com/leta199/Rejection-Sampling/tree/main/ExponentialProposal)  
|├── [ExponentialProposal](https://github.com/leta199/Rejection-Sampling/blob/main/Rejection%20sampling.r)        
|  ├──[]()  
│  ├──[]()   
│  └──[]()    
│  
|├── [GraphicalDisplays](https://github.com/leta199/Rejection-Sampling/tree/main/GraphicalDisplays)         
|  ├──[]()  
│  ├──[]()   
│  └──[]()    
│  
|├── [RejectionSampling-R]()     
|  ├──[]()  
│  ├──[]()   
│  └──[]()    
│  
|└──[README](https://github.com/leta199/Rejection-Sampling/blob/main/README.md)

## USEFUL RESOURCES 
The textbook "Probability with applications and R"  by Dr. Wagaman and Dr. Dobrow was very helpful in many of my endevours.  
[Rejection Sampling: Sampling from ‘difficult’ distributions](https://medium.com/@roshmitadey/rejection-sampling-sampling-from-difficult-distributions-dbd17742a919) - was a website that lays down the basics of rejection sampling.

## WHAT DOES THE FUTURE HOLD?   
1) Check distribution using histogram ✅
2) Check distribution using qqplot 
   
## AUTHORS   
[leta199](https://github.com/leta199)  
