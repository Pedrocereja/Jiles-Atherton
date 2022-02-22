clear all;
close all;

# Dados de entrada
## carrega H
load("Hext.mat");
## parâmetros do material no formato [k, c, a, Ms, alpha]
Parametros = [57.3, 0.27, 105, 1.58e6, 2e-4];
## tempo para plot
T = 8;
for i = 1:(T*10000)
  t(i) = T * 1/60 * (i-1) /(T*10000);
end

M = JA(H, 0, Parametros);
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
