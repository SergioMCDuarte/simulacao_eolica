
val <- function(retorno.anual, om.anual, invetimento.anual, taxa.atualizacao) {
  
}


simulacao.retorno <- function(potencia.turbina, 
                              numero.turbinas, 
                              tempo.vida, 
                              taxa.de.atualização, 
                              params.weibull, 
                              params.mistura) {
  
  
  # investimento inicial
  custo.inicial <- preco.instalacao(potencia.turbina, numero.turbinas)
  custos.recorrentes <- custos.om(potencia.turbina, numero.turbinas, tempo.vida)
  
  ano <- 1:tempo.vida 
  custo.anual <- replicate(tempo.vida, ((custo.inicial + custos.recorrentes) / tempo.vida))
  
  # calcular NPV do investimento
  atualizacao <- (1+taxa.de.atualização)**ano
  custo.anual.atualizado <- custo.anual/atualizacao

  ### energia produzida
  # velocidade do vento
  # potencia -> simulação horária (e = p*t -> t=1)
  
  energia <- replicate(tempo.vida, 
                       curva.potencia(rweibull(8760, shape = params.weibull$par[1], scale = params.weibull$par[2]), 
                                      pr=potencia.turbina)*numero.turbinas)
  
  preco.energia <- replicate(tempo.vida, preco.sim(8760, params.mistura))
  
  
  # rentabilidade
  rendimento.bruto <- colSums(energia*preco.energia)
  rendimento.liquido <- rendimento.bruto/atualizacao - custo.anual.atualizado

  return(sum(rendimento.liquido))
}