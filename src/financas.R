val <- function(a, r, i) {
  j <- 1:length(r)
  return(sum(Rj/(1+a)^j) - sum(Ij/(1+a)^(j-1)))
}

val.funcao.custo <- function(a,r,i) {
  
  return(sqrt(val(a,r,i)**2))
}

tir <- function(r,i,a.inical=0.01, l.inf=-1, l.sup=1) {
  params <- optim(a.inical, 
                  val.funcao.custo,
                  Rj,
                  Ij, 
                  method = "Brent", 
                  lower = l.inf, 
                  upper = l.sup)
  return(params$par)
}
