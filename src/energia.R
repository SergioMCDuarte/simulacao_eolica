
mle.mistura <- function(params) {
  
}

preco.medio <- function(dados) {
  return(mean(dados))
}


preco.sim <- function(n, params) {
  
  rvs <- c()
  for (j in 1:n) {
    U <- runif(1)
    cum.lambda <- 0
    for (i in 1:length(params$lambda)) {
      cum.lambda <- cum.lambda + params$lambda[i]
      if (U < cum.lambda) {
        rvs <- append(rvs, rnorm(1,params$mu[i], params$sigma[i]))
        break
      }
    }
  }
  return(sqrt(rvs**2))
}