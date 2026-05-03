#-----------------------------------#
#-REJECTION SAMPLING - Gamma(2,1) --#----
#-----------------------------------#
#Defining our target pdf(density function to sample from) --------------------------
target_pdf<-function(x){
  ifelse(x >= 5, (x*exp(-x))/(6*exp(-5)), 0) # to incorporate bounds
}

target_pdf_graphical<-function(x){
   (x*exp(-x))/(6*exp(-5))  # plotting the whole function  
}

#--------------------------------#
#--EXPONENTIAL PROPOSAL----------#----
#-------------------------------#
#Defining proposal pdf number generator(density that we easily sample from to use to accept or reject)--
exp_generator<- function(x){
  y <- rexp(1)     # generate a sample from exponential where lambda = 1
  ifelse(y>=5,y,0) # accept and return value of greater than or equal to 5
}

exp_graphical<- function(x){
  exp(-x) # plotting exponential proposal
}

# Graphing our target  and proposal probability density functions 
M <- ((5*exp(-5))/(6*exp(-5)))/(exp(-5)) # max point of both is x = 5

# PDF within bounds we consider x within (5,10)
curve(target_pdf(x), from = 5, to = 10, 
      xlab = "Input value",
      ylab = "Value of output",
      main = "Target and Proposal probability density function", col = "black", ylim = c(0,1))

# PDF compared to exp across greater range x within (0,10)
curve(target_pdf_graphical(x), from = 0, to = 10, 
      xlab = "Input value",
      ylab = "Value of output",
      main = "Target and Proposal probability density function", col = "pink2", ylim = c(0,20))
abline(v = 5)

curve( M * exp_graphical(x), from = 0, to = 10,
      xlab = "Input value",
      ylab = "Output value",
      main = "Proposal probability density funtion", add= T ,col = "blue4", lty = 2)
legend("topright", legend = c("Target PDF", "Proposal PDF"), 
       col = c("pink2", "blue4"), lty = c(1, 2))

#Rejection Sampling function -----------------------------------------------------
exp_acc_rej<-function(){
  
  set.seed(123)
  n<-5000
  sample_y<-numeric(n)
  number <- 0
  count<-0
  total_sample <-numeric(0)
  
  while(count<n) {
   
    #generated sample from proposal 
    y <- exp_generator()
    #uniform comparison
    u<- runif(1,0,1)
    #number of total generated samples
    number <- number + 1
    total_sample[number] <- y
    acceptance_rate <- round((length(sample_y)/ length(total_sample))*100 , digits = 3)
    
    #accept or reject criteria
    
    if( u <= target_pdf(y)/ (M * exp_graphical(y)))
    count<- count +1
    sample_y[count]<-y
    
  }
  number_of_samples <- length(total_sample)
  text <- "Acceptance rate:"
  percent <- "%"
  output<-paste(text,acceptance_rate,percent) #combining types to have preferred output 
  list( acceptance_rate = output, samples = sample_y, no_of_samples = number_of_samples ) #list of output from this function
}


list<- exp_acc_rej()   #creating a list of the acceptance rate and valid samples 
samples_gamma <- list$samples #creating a vector of the samples 
ac_rate <- list$acceptance_rate #acceptance rate 
no_samples <-list$no_of_samples  #number of total samples 
# Graphical display of distribution of sample and pdf ------------- -----------
# Using Histogram -------------------------------------------------------------
hist(samples_gamma, freq = FALSE,
     main = "Distribution of generated sample",
     xlab = "Sample values", ylim = c(0,2), xlim =c(0,10))
curve(target_pdf(x), add = TRUE)

# QQplot ----------------------------------------------------------------------
# We will now use a QQplot 
# Quantiles of the sample data 
sample_quantiles <- quantile(samples_gamma, probs = seq(0.1,1,0.01))
theoretical_quantiles <- qgamma(p = seq(0.1,1,0.01), shape =2 , rate =1)

plot(sample_quantiles, theoretical_quantiles, xlim = c(0,20), ylim = c(0,10))
abline(a= 0, b = 1)

#--------------------------------#
#--CAUCHY PROPOSAL--------------#----
#-------------------------------#

cauchy_proposal_graph<- function(x){
  ifelse(x>=5, (1/pi)*(1/(1+(x-1)^2)),0)
}

curve(cauchy_proposal_graph(x), from = 0, to =10)

#Scaling factor with Cauchy proposal ------------------------------------------
M_cauchy <- ((5*exp(-5))/(6*exp(-5)))/((1/pi)*(1/(1+5^2)))

curve(target_pdf(x), from = 0, to = 10, 
      xlab = "Input value",
      ylab = "Value of output",
      main = "Target and Proposal probability density function", col = "pink2", ylim = c(0,20))

curve(    M_cauchy * cauchy_proposal_graph(x), from = 0, to = 10,
       xlab = "Input value",
       ylab = "Output value",
       main = "Proposal probability density funtion", add= T ,col = "blue4", lty = 2)
legend("topright", legend = c("Target PDF", "Proposal PDF"), 
       col = c("pink2", "blue4"), lty = c(1, 2))

# Rejection sampling function ----------------------------------------------

rgamma_2_1_cauchy <- function(n){
  rgamma_samples <- numeric(n) # list to store accepted samples 
  total_samples <- numeric(0)  # store total sample size 
  count <- 1                  #iterate our  while loop
  pos <- 1
  # while loop that runs until we have 5000 accepted samples 
  while (count < n) {
    # random value from a uniform distribution for comparison
    u <- runif(1, 0, 1)
    # value from cauchy distribution 
    x <- 5 + rcauchy( 1, 0, 1)
    # iterating along the list 
    pos  <- pos + 1
    total_samples[pos] <- x
    # now we can use the comparison operator to accept samples if the condition is met
    if ( u <= target_pdf(x)/(M_cauchy * cauchy_proposal_graph(x))){
      count <- count + 1
      rgamma_samples[count] <- x
    }
    
  }
  return(rgamma_samples)
}

gamma_samples_cauchy <- rgamma_2_1_cauchy(n = 5000)

hist(gamma_samples_cauchy, freq = F)
curve(target_pdf(x), add = TRUE)

sample_quantiles_cauchy <- quantile(gamma_samples_cauchy, probs = seq(0.1,1,0.01))
theoretical_quantiles_cauchy <- qcauchy(p = seq(0.1,1,0.01),1,1)

plot(sample_quantiles_cauchy, theoretical_quantiles_cauchy)
abline(a= 0, b = 1)

