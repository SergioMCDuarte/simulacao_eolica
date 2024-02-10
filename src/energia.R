
preco.medio <- function(dados) {
  return(mean(dados))
}


preco.sim <- function(n, params) {
  
  rvs.preco <- sqrt(rmvnormmix(n, 
                               lambda = params$lambda,
                               mu=params$mu, 
                               sigma = params$sigma)**2)
  
  return(rvs.preco)
}