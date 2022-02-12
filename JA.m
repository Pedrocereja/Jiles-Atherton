function M = JA(H, Mo, h)
  # A funcao retorna o vetor da magnetizacao, M, a partir dos argumentos:
  # - H:   vetor do campo magnetico externo aplicado;
  # - Mo: condicao inicial para a magnetizacao;
  # - h:    passo de calculo para o metodo de euler.
  
  numero_pontos = length(H); ### o vetor M possuira o mesmo numero de pontos que H

  ## Constantes e condicao inicial
  k=400;
  c=0.2;
  a=1100;
  uo = 4*pi()*1e-7;
  Ms=1.8e6;
  alpha=1.6e-3;
  M(1) = Mo;

  for i = 1:numero_pontos-1
    ## Equacoes auxiliares
    He = H(i) + alpha*M(i);
    if abs(He/a) <= 0.1 ### para valores pequenos de He e preciso expandir a formulacao em series de Taylor, do contrario o resultdo vai para infinito
      Man(i) = Ms * (He/(3*a) - ((He/a)^ 2)/45);
      dMan_dHe = Ms * (1/(3*a));
    else
      Man(i) = Ms*(coth(He/a) - a/He);
      dMan_dHe = (Ms/a)*(1-(coth(He/a))^2+(a/He)^2);
    end
    ### delta
    dH=(H(i+1)-H(i))
    if dH >= 0
        delta=1;
    else
        delta=-1;
    end
    
    ## Equacao derivativa
    dM_dH(i) = 1/(1+c) * (Man(i)-M(i))/(delta*k/uo - alpha*(Man(i)-M(i)));
    dM_dH(i) += c/(1+c) * dMan_dHe;
    
    ## Método de euler
    M(i+1) = M(i) + dH*dM_dH(i); ### passo de calculo esta estranho, ajeitar para h
  end
  
  ## Debug
  debug_mode = 0;
  if debug_mode == 1
    ### curva anisteretica
    Man(numero_pontos) = Ms*(coth(He/a) - a/He);
    subplot(1, 2, 1)
    plot(H,  Man);
    xlabel('H');
    ylabel('Man');
  endif
endfunction