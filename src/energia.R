
preco.medio <- function(dados) {
  return(mean(dados))
}


preco.sim <- function(n, params) {
  
  rvs.preco <- abs(rmvnormmix(n, 
                               lambda = params$lambda,
                               mu=params$mu, 
                               sigma = params$sigma))
  
  return(rvs.preco)
}