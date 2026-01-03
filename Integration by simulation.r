#Monte Carlo Integration- Integration by Simulation-------------------------
#Defining our target pdf(density function to integrate) --------------------------
install.packages("ggplot2")
library(ggplot2)

target_pdf<-function(x){
  (x*exp(-x))/(6*exp(-5))
}

#Defining proposal pdf (density that we sample from a compare to target)--
proposal_pdf<- function(x){
  5 + exp(-(x - 5))
}
#Graphing our target probability density function 
curve(target_pdf(x), from = 5, to =10, 
      xlab = "Input value",
      ylab = "Value of output")

curve(proposal_pdf(x))


sim_gamma<-function(){
  set.seed(123)
  n<-5000
  sample_y<-numeric(n)
  count<-0
  while(count<n) {
    y<-proposal_pdf(1)
    #uniform comparison
    u<- runif(1,0,1)
    #accept or reject criteria
    
    if( u <target_pdf(y)/proposal_pdf(y))
      count<- count +1
    sample_y[count]<-y
    
  }
  return(sample_y)
}

#Combined 
hist(sim_gamma(), freq = FALSE)
curve(target_pdf(x), add = TRUE)
