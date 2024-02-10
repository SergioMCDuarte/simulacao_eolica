
weibull.log.likelihood <- function(params, dados){
  # beta: shape
  # theta: scale
  
  beta <-  params[1]
  theta <- params[2]
  n = length(dados)
  
  return(-(n*log(beta) - n*beta*log(theta) + sum( (beta-1) * log(dados) - (dados/theta)^beta )))
  #return(-sum(dweibull(dados, beta, theta, log = TRUE)))
}


mle.weibull <- function(dados, beta=1, theta=1) {
  
  params <- optim(par=c(beta=beta, theta=theta), 
                  fn=weibull.log.likelihood, 
                  dados=dados)
  
  return(params)
}


rvento.mcmc <- function(n) {
  #TBD
}

