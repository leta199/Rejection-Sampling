# Rejection Sampling ----------------------------------------------------------------------
# Defining our target pdf (density function to sample from) --------------------------
# Target proposal generator 
target_pdf<-function(x){
  (x*exp(-x))/(6*exp(-5))
}

# Defining proposal pdf number generator(density function that we use to accept or reject)--
# Proposal value generator 
proposal_pdf<- function(x){
  rgamma(x, shape = 2, rate =1)
}

# Proposal - probability density function 
proposal_pdf_graph <- function(x){
  dgamma(x, shape = 2, rate =1)
}

# Graphing our target  and proposal probability density functions 
xx = seq(5, 10, length.out = 10000)
M <- max(target_pdf(xx)/proposal_pdf(xx))

curve(target_pdf(x), from = 5, to = 10, 
      xlab = "Input value",
      ylab = "Value of output",
      main = "Target probability density function")

curve( M * proposal_pdf_graph(x), from = 5, to = 10,
      xlab = "Input value",
      ylab = "Output value",
      main = "Proposal probability density funtion")

# Rejection Sampling function ------------------------------------
rgamma_2_1<-function(x){
  set.seed(123)
  n <-5000
  sample_y<-numeric(n) 
  number <- 0
  count<-0
  total_sample <-numeric(0)
  while(count<n) {
    count<- count +1
    #generated sample from proposal 
    y<-proposal_pdf(1)
    #uniform comparison
    u<- runif(1,0,1)
    #number of total generated samples
    number <- number + 1
    total_sample[number] <- y
    acceptance_rate <- round((length(sample_y)/ length(total_sample))*100 , digits = 3)
    
    #accept or reject criteria
    if( u < target_pdf(y)/ M * proposal_pdf(y))
    sample_y[count]<-y
    
  }
  number_of_samples <- length(total_sample)
  text <- "Acceptance rate:"
  percent <- "%"
  output<-paste(text,acceptance_rate,percent) #combining types to have preferred output 
  list( acceptance_rate = output, samples = sample_y, no_of_samples = number_of_samples ) #list of output from this function
}

list<- rgamma_2_1()   #creating a list of the acceptance rate and valid samples 
plot <- list$samples #creating a vector of the samples 
list$acceptance_rate #acceptance rate 
list$no_of_samples.  #number of total samples 
# Graphical display of distribution of sample and pdf ------------- 
# Using Histogram -------------------------
hist(plot, freq = FALSE,
     main = "Distribution of generated sample",
     xlab = "Sample values")
curve(target_pdf(x), add = TRUE)

# Using QQplot -------------------------


