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
set.seed(123)
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
    
    if( u <= target_pdf(y)/ (M * exp_graphical(y))){
    count<- count +1
    sample_y[count]<-y
    }
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
     xlab = "Sample values", ylim = c(0,2), xlim =c(5,10))
curve(target_pdf(x), add = TRUE)

# QQplot ----------------------------------------------------------------------
# We will now use a QQplot 
# Quantiles of the sample data 
sample_quantiles <- quantile(samples_gamma, probs = seq(0.1,1,0.01))
theoretical_quantiles <- qgamma(p = seq(0.1,1,0.01), shape =2 , rate =1)

plot(sample_quantiles, theoretical_quantiles, xlim = c(0,20), ylim = c(0,10),
     main = "Theortical vs sample quantiles for exp proposal",
     ylab = "Theortical quantiles",
     xlab = "Sample quantiles")

abline(a= 0, b = 1)

# Conclusion
# We can see that using en exponential(1) is very inefficient as most values are that we generate are 
# Exp(1) is very inefficient - generates many values to get sample size = 5000 
# Mean of exp = 1, mean of gamma = 2 so our QQ-plot shows mean of exp < mean of gamma 
# We can look into being more efficient 

#--------------------------------#
#--CAUCHY PROPOSAL--------------#----
#-------------------------------#
cauchy_generator<- function(x){
  y <- rcauchy(1, 5)
  ifelse(y>=5,y,0)
}

cauchy_graphical<- function(x){
  (1/pi)*(1/(1+(x-5)^2))
}

curve(cauchy_proposal_graph(x), from = 0, to =10)

#Scaling factor with Cauchy proposal ------------------------------------------
M_cauchy <- ((5*exp(-5))/(6*exp(-5)))/((1/pi)*(1/(1+5^2)))

curve(target_pdf_graphical(x), from = 0, to = 10, 
      xlab = "Input value",
      ylab = "Value of output",
      main = "Target and Proposal probability density function", col = "pink2", ylim = c(0,25))
abline(v = 5)
curve( M_cauchy * cauchy_graphical(x), from = 0, to = 10,
       xlab = "Input value",
       ylab = "Output value",
       main = "Proposal probability density funtion", add= T ,col = "blue4", lty = 2)
legend("topright", legend = c("Target PDF", "Proposal PDF"), 
       col = c("pink2", "blue4"), lty = c(1, 2))

# Rejection sampling function ----------------------------------------------
set.seed(123)
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
    x <- cauchy_generator()
    # iterating along the list 
    pos  <- pos + 1
    total_samples[pos] <- x
    
    #number of total generated samples
    pos <- pos + 1
    total_samples[pos] <- x
    acceptance_rate <- round((length(rgamma_samples)/ length(total_samples))*100 , digits = 3)
    
    # now we can use the comparison operator to accept samples if the condition is met
    if ( u <= target_pdf(x)/(M_cauchy * cauchy_graphical(x))){
      count <- count + 1
      rgamma_samples[count] <- x
    }
    
  }
  number_of_samples <- length(total_samples)
  text <- "Acceptance rate:"
  percent <- "%"
  output<-paste(text,acceptance_rate,percent) #combining types to have preferred output 
  list( acceptance_rate = output, samples = rgamma_samples, no_of_samples = number_of_samples ) #list
}

list_cauchy <- rgamma_2_1_cauchy(5000)
gamma_samples_cauchy <- list_cauchy$samples
acc_rate_cauchy <- list_cauchy$acceptance_rate
no_samples_cauchy <- list_cauchy$no_of_samples

hist(gamma_samples_cauchy, freq = F)
curve(target_pdf(x), add = TRUE)

sample_quantiles_cauchy <- quantile(gamma_samples_cauchy, probs = seq(0.1,1,0.01))
theoretical_quantiles_cauchy <- qcauchy(p = seq(0.1,1,0.01),1,1)

plot(sample_quantiles_cauchy, theoretical_quantiles_cauchy)
abline(a= 0, b = 1)

increase_efficiency <- ((no_samples-no_samples_cauchy)/no_samples)*100

# Conclusion
# Although we have. slight improvement in efficiency, the Cauchy is still very wasteful when centered on 5
# That means we always have half of the samples being unuseable fro 5 to - infinity

#--------------------------------#
#--SHIFTED EXPONENTIAL PROPOSAL--#----
#-------------------------------#
# Now let's try a shifted exponential 
# This will be our best bet since a shifted exponential distribution has the same support as Gamma 

# Shifted exp will be centered on 5 
shift_exp_generator<- function(x){
   5 + rexp(1)     # generate a sample from exponential where lambda = 1 
}

shift_exp_graphical<- function(x){
  ifelse(x >= 5, exp(-(x-5)),0) # plotting exponential proposal
}

# we still have the max value of both graphs at x = 5
function_exp <- function(x) ((x*exp(-x))/(6*exp(-5)))/exp(-(x-5))
shift_M <- optimize(function_exp, interval = c(5,10), maximum = T)
scaling_factor <- shift_M$objective
# PDF compared to shifted exp across greater range x within (0,10)
curve(target_pdf_graphical(x), from = 5, to = 10, 
      xlab = "Input value",
      ylab = "Value of output",
      main = "Target and Proposal probability density function", col = "pink2", ylim = c(0,2))
abline(v = 5)

curve( M * shift_exp_graphical(x), from = 5, to = 10,
       xlab = "Input value",
       ylab = "Output value",
       main = "Proposal probability density funtion", add= T ,col = "blue4", lty = 2)
legend("topright", legend = c("Target PDF", "Proposal PDF"), 
       col = c("pink2", "blue4"), lty = c(1, 2))

#Rejection Sampling function -----------------------------------------------------
set.seed(123)
shift_exp_acc_rej<-function(){
  
  set.seed(123)
  n<-5000
  sample_y<-numeric(n)
  number <- 0
  count<-0
  total_sample <-numeric(0)
  
  while(count<n) {
    
    #generated sample from proposal 
    y <- shift_exp_generator()
    #uniform comparison
    u<- runif(1,0,1)
    #number of total generated samples
    number <- number + 1
    total_sample[number] <- y
    acceptance_rate <- round((length(sample_y)/ length(total_sample))*100 , digits = 3)
    
    #accept or reject criteria
    
    if( u <= target_pdf(y)/ scaling_factor*(shift_exp_graphical(y))){
      count<- count +1
      sample_y[count]<-y
    }
  }
  number_of_samples <- length(total_sample)
  text <- "Acceptance rate:"
  percent <- "%"
  output<-paste(text,acceptance_rate,percent) #combining types to have preferred output 
  list( acceptance_rate = output, samples = sample_y, no_of_samples = number_of_samples ) #list of output from this function
}


shift_list<- shift_exp_acc_rej()   #creating a list of the acceptance rate and valid samples 
shift_samples_gamma <- shift_list$samples #creating a vector of the samples 
shift_ac_rate <- shift_list$acceptance_rate #acceptance rate 
shift_no_samples <-shift_list$no_of_samples  #number of total samples 
# Graphical display of distribution of sample and pdf ------------- -----------
# Using Histogram -------------------------------------------------------------
hist(shift_samples_gamma, freq = FALSE,
     main = "Distribution of generated sample",
     xlab = "Sample values", ylim = c(0,2), xlim =c(5,10))
curve(target_pdf(x), add = TRUE)

# QQplot ----------------------------------------------------------------------
# We will now use a QQplot 
# Quantiles of the sample data 
shift_sample_quantiles <- quantile(shift_samples_gamma, probs = seq(0.1,1,0.01))
shift_theoretical_quantiles <- qgamma(p = seq(0.1,1,0.01), shape =2 , rate =1)

plot(shift_sample_quantiles, shift_theoretical_quantiles, xlim = c(0,20), ylim = c(0,10),
     main = "Theortical vs sample quantiles for exp proposal",
     ylab = "Theortical quantiles",
     xlab = "Sample quantiles")

abline(a= 0, b = 1)

