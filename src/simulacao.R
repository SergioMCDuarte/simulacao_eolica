

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
  
  
  energia <- matrix(curva.potencia(rweibull(n=8760*tempo.vida, 
                                            shape=params.weibull$par[1], 
                                            scale=params.weibull$par[2]), 
                          pr=potencia.turbina)*numero.turbinas,
                    ncol = tempo.vida)
  

  preco.energia <- matrix(preco.sim(8760*tempo.vida, params.mistura), 
                          ncol = tempo.vida)
  
  # rentabilidade
  rendimento.bruto <- colSums(energia*preco.energia)
  rendimento.liquido <- rendimento.bruto/atualizacao - custo.anual.atualizado

  return(sum(rendimento.liquido))
}