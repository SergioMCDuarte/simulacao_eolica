val <- function(a, R, I) {
  j <- 1:length(R)
  return(sum((R)/(1+a)^j) - sum(I))
}

val.funcao.custo <- function(a,R,I) {
  return(abs(val(a,R,I)))
}

tir <- function(R,I,a.inical=0.01, l.inf=-1, l.sup=1) {
  params <- optim(a.inical, 
                  val.funcao.custo,
                  R=R,
                  I=I, 
                  method = "Brent", 
                  lower = l.inf, 
                  upper = l.sup)
  return(params)
}
