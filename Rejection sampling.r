#Rejection Sampling ----------------------------------------------------------------------
#Defining our target pdf (density function to sample from) --------------------------
target_pdf<-function(x){
  (x*exp(-x))/(6*exp(-5))
}

#Defining proposal pdf number generator(density function that we use to accept or reject)--
proposal_pdf<- function(x){
  5 + rexp(1, rate =1)
}
proposal_pdf_graph<- function(x){
  5 + exp(-(x - 5))
}
#Graphing our target  and proposal probability density functions 
curve(target_pdf(x), from = 5, to =10, 
      xlab = "Input value",
      ylab = "Value of output",
      main = "Target probability density function")

curve(proposal_pdf_graph(x), from = 5, to = 10,
      xlab = "Input value",
      ylab = "Output value",
      main = "Proposal probability density funtion")

#Rejection Sampling function ------------------------------------
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
    
    if( u < target_pdf(y)/proposal_pdf(y))
      count<- count +1
    sample_y[count]<-y
    
  }
  return(sample_y)
}

#Graphical display of distribution of sample and pdf ------------- 
hist(sim_gamma(), freq = FALSE,
     main = "Distribution of generated sample",
     xlab = "Sample values")
curve(target_pdf(x), add = TRUE)
