
preco.instalacao <- function(potencia.nominal, numero.turbinas) {
  # 1297 €/kW
  return(numero.turbinas * 1297000 * potencia.nominal)
}

custos.om <- function(potencia.nominal, numero.turbinas, tempo.vida) {
  return(preco.instalacao(potencia.nominal, numero.turbinas)*0.015*tempo.vida)
}