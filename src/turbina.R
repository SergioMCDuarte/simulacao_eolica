
curva.potencia <- function(velocidade.vento,
                           cut.in.speed = 3,
                           cut.off.speed = 25.0,
                           pr.speed = 15,
                           pr = 1.0 ) {
  #https://ewtdirectwind.com/products/dw61/
  
  p.out <- velocidade.vento
  
  p.out <- ifelse(p.out < cut.in.speed, 0, p.out)
  p.out <- ifelse(p.out > cut.off.speed, 0, p.out)
  p.out <- ifelse(p.out > pr.speed, pr, p.out)
  
  p.out <- ifelse((p.out >= cut.in.speed) & (p.out < pr.speed), 
                  pr / (1 + exp(-(p.out-9.0134)/.9)), 
                  p.out)
  
  return(p.out)
}


preco.instalacao <- function(potencia.nominal, numero.turbinas) {
  # 1297 €/kW
  return(numero.turbinas * 1297000 * potencia.nominal)
}

custos.om <- function(potencia.nominal, numero.turbinas, tempo.vida) {
  return(preco.instalacao(potencia.nominal, numero.turbinas)*0.02*tempo.vida)
}