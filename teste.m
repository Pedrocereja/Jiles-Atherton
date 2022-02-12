clear all;
close all;

# Dados da simulacao
numero_pontos = 10000;
numero_periodos = 6;
f = 60;

# Condicoes iniciais
for i = 1:(numero_periodos*numero_pontos)
  t(i) = numero_periodos * 1/f * (i-1) /(numero_periodos*numero_pontos);
  H(i) =6e3*sin(2*pi*f*t(i));    
end

M = JA(H, 0, .1, t);
#uo = 4*pi()*1e-7;
#B = (M + H)*uo;

#subplot(1,3,1);
#plot(t,B);
#xlabel('Tempo[s]');
#ylabel('B');
if 1
  subplot(1,2,1);
  plot(t,M);
  xlabel('Tempo[s]');
  ylabel('M');

  subplot(1,2,2);
  plot(H,M);
  xlabel('H[A/m]');
  ylabel('M');
endif