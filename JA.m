function M = JA(H, Mo, Parametros)
  # A funcao retorna o vetor da magnetizacao, M, a partir dos argumentos:
  # - H:   vetor do campo magnetico externo aplicado;
  # - Mo: condicao inicial para a magnetizacao.
  # - Parametros: parâmetros do material no formato [k, c, a, Ms, alpha]
  
  numero_pontos = length(H); ### o vetor M possuira o mesmo numero de pontos que H
  
  ## Constantes e condicao inicial
  p = Parametros;
  k=p(1);
  c=p(2);
  a=p(3);
  Ms=p(4);
  alpha=p(5);
  uo = 4*pi()*1e-7;
  M(1) = Mo;

  for i = 1:numero_pontos-1
    ## Equacoes auxiliares
    He = H(i) + alpha*M(i);
    if abs(He/a) <= 0.1 ### para valores pequenos de He e preciso expandir a formulacao em series de Taylor, do contrario o resultdo vai para infinito
      Man = Ms * (He/(3*a));
      dMan_dHe = Ms * (1/(3*a));
    else
      Man = Ms*(coth(He/a) - a/He);
      dMan_dHe = (Ms/a)*(1-(coth(He/a))^2+(a/He)^2);
    end
    ### delta
    dH=(H(i+1)-H(i));
    if dH >= 0
        delta=1;
    else
        delta=-1;
    end
    
    ## Equacao derivativa
    #dM_dH = 1/(1+c) * (Man(i)-M(i))/(delta*k/uo - alpha*(Man(i)-M(i)));
    #dM_dH += c/(1+c) * dMan_dHe;
    dM_dH = c*dMan_dHe + (1-c)*(Man - M(i)) / (k*delta*(1-c)-alpha*(Man-M(i)));
    dM_dH /= (1- alpha*c);
    
    ## Método de euler
    M(i+1) = M(i) + dH*dM_dH;
  end
endfunction
