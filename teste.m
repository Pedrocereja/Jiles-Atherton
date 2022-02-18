clear all;
close all;



# Dados da simulacao
numero_pontos = 10000;
numero_periodos = 8;
f = 60;

# Condicoes iniciais
for i = 1:(numero_periodos*numero_pontos)
  t(i) = numero_periodos * 1/f * (i-1) /(numero_periodos*numero_pontos);
  H(i) =6e3*sin(2*pi*f*t(i));    
end

#load("Hext.mat");

M = JA(H, 0);
#uo = 4*pi()*1e-7;
#B = (M + H)*uo;

if 1
  subplot(1,3,1);
  plot(t,H);
  xlabel('Tempo[s]');
  ylabel('H');

  subplot(1,3,2);
  plot(t,M);
  xlabel('Tempo[s]');
  ylabel('M');

  subplot(1,3,3);
  plot(H,M/1.6e6);
  xlabel('H[A/m]');
  ylabel('M');
endif
