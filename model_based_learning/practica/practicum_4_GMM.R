# Tutorial EM for GMMs
# 
# 1) Implementing the EM
# 
# Implement (from scratch) the EM for a GMM on the variables 2 and 4 of the wine data set. Cluster the data and compare your results with k-means.
# An R file called "useful_functions.R"can be useful for EM. Apart from that, try not to use packages to implement EM.
# To assess the quality of the clustering, you may use the function classError and/or adjustedRandIndex from the Mclust package.
#
# 2) Model selection
# 
# Try to find a relevant nulmber of clusters using the three methods seen in class: AIC, BIC, and (cross-)validated likelihood.
# 
# 3) Towards higher dimensional spaces
# 
# Try to model more than just two variables of the same data set. Do you find the same clusters, the same number of clusters.
# 


#### First we load the data and look at it

library(pgmm)
setwd("~/Dev/UCA_MSc-DS2/model_based_learning/practica")
source("practicum_4_useful_funcs.R")

data(wine)

X = as.matrix(wine[,c(2,4)])
y = wine[,1]
plot(X,col=y)

# E Step: compute the responsibilities

initialization <- function(data) {
  mus = as.matrix(list(mean(data[,1]), mean(data[,2])))
  sigmas = list(cov(data), cov(data))
  props = as.matrix(list(1/3, 1/3, 1/3))
  return(list(mus = mus, sigmas = sigmas, props = props))
}

# It is usually easier to compute the log of gamma rather than gamma by itself
# log(gamma) = log(w_k) - log(sum_k=1^K w_k) = log(w_k) - log(sum_k=1^K exp(log(w_k)))

#E_step <- function(data, params) {
#  N = nrow(X); K=3
#  gammas = matrix(0, n, k)
#  for (n in 1:N){
#    for (k in 1:K){
#      params
#      gammas[n, k] = 
#    }
#  }
#}

EM1d <- function(X, K, max_it=50) {
  n = length(X)
  # Intialization step of \theta^0
  #   mu <- rep(NA, K) 
  #   not possible to initialize with X_mean because 
  #   it would become an instant local maximum
  mu <- rnorm(K, mean(x), sd=1)
  prop <- rep(1/K, K) # corresponds to \pi
  sigma <- rep(1, K) # because if the initialization of mu as a normal var.
  gamma <- matrix(NA, n, K)
  # EM step
  for (i in 1:max_it) {
    # Expectation step
    for (k in 1:K) {
      gamma[,k] = prop[k]*dnorm(X,mu[k],sigma[k])
    }
    ## normalize each line of gamma 
    # Maximization step
    for (k in 1:k){
      nk = sum(gamma[,k])
      prop[k] = nk/n
      mu[k] = sum(gamma[,K]*X)/nk
      sigma[k] sum(gamma[,K]*(X-mu[k])^2)
    }
  }
}






