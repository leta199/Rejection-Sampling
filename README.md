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

<img width="340" height="77" alt="Image" src="https://github.com/user-attachments/assets/1af3f8ce-0295-40cd-904f-05885e4c2758" />    

**Target probability density function**  
This is the Gamma(2,1) function we must sample from where x >= 5.   
The function that we define our probability density function  from is: 

`target_pdf(x)`     
<img width="762" height="514" alt="Image" src="https://github.com/user-attachments/assets/9b26809e-fdf3-4a03-8ab8-df2fb0ab6a0b" />

The support of our pdf creates the following area: 
<img width="767" height="524" alt="Image" src="https://github.com/user-attachments/assets/85556ede-1d36-4998-8721-ccf4a2692106" />

**Proposal probability density function**  
This is a known probability distribution that we can easily sample from e.g in R.   
It must follow the following criteria:  
 **i**  Cover the target pdf i.e there must be some M where:  M * proposal_pdf(x) >= target_pdf(x) for any x in the support. 

### **Exponential Distribution  \~ exp(0.8)**   
Initially, I wanted to use an exponential distribution however I soon ran into a few problems.  
For this  proposal distribution, I seleced an exponential distribution with lambda = 0.8.     
This was to allow for the decay of the exponential to be less than that of the Gamma distribution. 

We then have to find the scaling factor M so that we can fulfill condition 1 above. 
To find this value we used the logic in the Mathematics note here:  [Math Note exponential(0.8)](https://github.com/leta199/Rejection-Sampling/blob/main/ExponentialProposal/Rejection_sampling_exp_0_8_-2.pdf)  
After finding this scaling factor, we plotted the graph of exponential(0.8) below: 

<img width="764" height="517" alt="Image" src="https://github.com/user-attachments/assets/8309118b-1279-4ffb-96de-04a107d4c284" />

Then we can compare the exponential(0.8) to our target pdf:
<img width="768" height="520" alt="Image" src="https://github.com/user-attachments/assets/97769da6-f5a9-4393-91ca-7a7253d71988" />

- We can see that the exponential fits the Gamma(2,1) target very well however, we have not since we only want to generate values from x >= 5, we reject many of our generated sampled from exponential.
- Therefore, we will likely have many rejections making the function inefficient. 

#### Rejection Sampling 
The `rgamma_2_1_exp` function implements the core rejection sampling logic. It iteratively generates candidates and filters them based on the calculated scaling factor M.

**Initialization**  
n <- 5000: Defines the target number of accepted samples.  
`sample_y`: A pre-allocated vector to store accepted values (improves performance).  
`total_sample`: Tracks every attempt (successes and failures) to measure algorithm efficiency.  
`count`: Tracks current successful iterations.

**The Simulation Loop**  
The function uses a while loop that runs until count reaches n:  
Proposal Generation: Calls exp_generator() to draw a candidate y from the Exponential distribution.  
Comparison Variable: Generates u∼Uniform(0,1) to serve as the "threshold" for the acceptance test.

**Acceptance Criterion:**  
The algorithm uses if statement to check if: u≤ f(y)/M⋅g(y), where g(y) is the exponential proposal density function 
	
If True: The candidate y is stored in sample_y and count increments.

If False: The candidate is discarded, and the loop repeats.

**Return Values**

The function returns a list containing three key outputs:  
`acceptance_rate`: A formatted string showing the percentage of successful proposals vs. total attempts.  
`samples`: The final vector of values representing the target distribution.  
`no_of_samples`: The total iterations required (useful for complexity analysis).

We can see that we have managed to generate data from the Gamma(2,1) using rejection sampling and proposal exp(0.8). 
*Histogram*: 

<img width="769" height="516" alt="Image" src="https://github.com/user-attachments/assets/bb63dc22-63d0-4c0b-932f-ce80049049b5" />

We can also verify that the generated samples are from the Gamma(2,1) distribution using the *QQ plot*: 
<img width="762" height="518" alt="Image" src="https://github.com/user-attachments/assets/dff18a0b-4cb4-4b32-8158-db47b1fc32c4" />

- The QQ plot is slightly shifted downwards as the mean of our Exponential(0.8) is 1.25 and less than of the Gamma(2,1) at 2.

### **Shifted Cauchy Distribution \~ 5 + cauchy(1)**  
Cuachy distributions are calssically heavier tailed than T or Normal or  distirbutions therefore, this was the second proposal to be used.   
After finding the approartite scaling scaling factor, we plotted the graph of cauchy(5) below: 
<img width="751" height="515" alt="Image" src="https://github.com/user-attachments/assets/f8d823ec-0d63-4a26-9e3c-701aadf4ceb8" />

Then we can compare the cauchy(5) to our target pdf:
<img width="766" height="518" alt="Image" src="https://github.com/user-attachments/assets/5e53f187-9112-416f-a3b9-d0727a681d11" />

We then use the same rejection sampling algoirthm that we had above and we can investiagte the geneated values and compare the efficiencies of the two methods.     
We then generate samples using the `rgamma_2_1_cauchy` function. 
We can see that we have generated the appropriate sample values using the histogram below:
<img width="754" height="519" alt="Image" src="https://github.com/user-attachments/assets/fe811c85-1c5a-4c53-a45e-7bd54e3e6415" />

Our QQ plot is very similar to that of the exponential(0.8) proposal:
<img width="759" height="521" alt="Image" src="https://github.com/user-attachments/assets/0f1198d1-c22f-4b67-99a3-e29c9b25d416" />

**Efficiency of Proposal**  
To inverstigate the change in effieciny we used the formula:   

$$
\frac{\text{Var}(P_{\text{cauchy}}) - \text{Var}(P_{\text{exp}})}{\text{Var}(P_{\text{exp}})}
$$

By utilisng the cauchy distribution, we have acieved a 9.8% improvement in data generation regarding variance.   
However, eventhough we had improved variance, the number of samples we generate was still very high at 133% more samples needed for the Cauchy.  
The main takeawasy would be that:
- The shifted nature of the Cauchy proposal helps reduce the variance of our samples.
- The Cauchy does not have the same support as the Gamma(2,1). Cauchy is supported from - to + infinity while the Gamma(2,1) is supported on x >= 5. This means that half of our samples are automatically rejected with is a waste of samples.
- Let us try using a sifted exponential(0.8) to compare the efficiecncy. 

### **Shifted Exponential Distribution \~ 5 + exp(0.8)**  
For this proposal, we will use a shifted exponential with the same lambda of 0.8 above.  
We can see that this shifted exponential fits even better than the above exponential:  

<img width="765" height="518" alt="Image" src="https://github.com/user-attachments/assets/8b0f121a-8fe3-4389-8e18-2bbefcff66bf" />

We use the same method of rejection sampling as above by using the function `rgamma_2_1_shift_exp`.
We can see that this same sample follows the Gamma(2,1) distirbution:
<img width="761" height="512" alt="Image" src="https://github.com/user-attachments/assets/393a9cd9-46c0-4787-b6a2-2beda9ebc378" />

 ## PROJECT STRUCTURE      
|[Simulation- Rejection Sampling](https://github.com/leta199/Rejection-Sampling/tree/main/ExponentialProposal)  
|├── [ExponentialProposal](https://github.com/leta199/Rejection-Sampling/blob/main/Rejection%20sampling.r)        
|  ├──[Rejectionsampling_exp(0.8](https://github.com/leta199/Rejection-Sampling/blob/main/ExponentialProposal/Rejection_sampling_exp_0_8_-2.pdf)  
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
