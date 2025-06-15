close all
clear all
clc
s=tf('s');
%% Integrador 
R2=220e3;
C2=22e-9;
G1=1/(R2*C2*s+1);
tau2=R2*C2
wc2=1/tau2
fc2=wc2/(2*pi)
p1=pole(G1);
%% RLC
Rmin=200;
Rmax=20e3;
N=100;
Rs=linspace(Rmin,Rmax,N);
L=560e-3; %valor da indutancia
C=69e-09; %valor do capacitor
wn=1/sqrt(L*C);
Rc=2*L*wn;
%% resposta em frequencia
w=2*pi*1e-4:0.01:2*pi*300; %define vetor de frequências
[mag0,pha0,w]=bode(G1,w); %obtem magnitude e fase para o sistema
mag0=squeeze(mag0); %reduz dimensão do vetor para o plot
pha0=squeeze(pha0); %reduz dimensão do vetor para o plot
% caso 1 (R>Rc)
R=2*Rc; %valor do resistor do RLC
xi=R/(2*L*wn);
G2=tf([wn^2],[1 2*xi*wn wn^2]); %define função de transferencia no formato G(s)=num/den
[mag2_1,pha2_1,w]=bode(G2,w); %obtem magnitude e fase para o sistema
mag2_1=squeeze(mag2_1); %reduz dimensão do vetor para o plot
pha2_1=squeeze(pha2_1); %reduz dimensão do vetor para o plot
G=G1*G2 %integrador em serie com RLC
[mag1,pha1,w]=bode(G,w); %obtem magnitude e fase para o sistema
mag1=squeeze(mag1); %reduz dimensão do vetor para o plot
pha1=squeeze(pha1); %reduz dimensão do vetor para o plot
% caso 2 (R<Rc)
R=1/2*Rc; %valor do resistor do RLC
xi=R/(2*L*wn);
G2=tf([wn^2],[1 2*xi*wn wn^2]); %define função de transferencia no formato G(s)=num/den
[mag2_2,pha2_2,w]=bode(G2,w); %obtem magnitude e fase para o sistema
mag2_2=squeeze(mag2_2); %reduz dimensão do vetor para o plot
pha2_2=squeeze(pha2_2); %reduz dimensão do vetor para o plot
G=G1*G2 %integrador em serie com RLC
[mag2,pha2,w]=bode(G,w); %obtem magnitude e fase para o sistema
mag2=squeeze(mag2); %reduz dimensão do vetor para o plot
pha2=squeeze(pha2); %reduz dimensão do vetor para o plot
% caso 3 (R=Rc)
R=Rc; %valor do resistor do RLC
xi=R/(2*L*wn);
G2=tf([wn^2],[1 2*xi*wn wn^2]); %define função de transferencia no formato G(s)=num/den
[mag2_3,pha2_3,w]=bode(G2,w); %obtem magnitude e fase para o sistema
mag2_3=squeeze(mag2_3); %reduz dimensão do vetor para o plot
pha2_3=squeeze(pha2_3); %reduz dimensão do vetor para o plot
G=G1*G2 %integrador em serie com RLC
[mag3,pha3,w]=bode(G,w); %obtem magnitude e fase para o sistema
mag3=squeeze(mag3); %reduz dimensão do vetor para o plot
pha3=squeeze(pha3); %reduz dimensão do vetor para o plot
%% plot
figure
subplot(2,1,1) %define subfigura 1
hold on
semilogx(w/(2*pi),20*log10(mag0),'linewidth',2,DisplayName='Integrador')%plota magnitude
semilogx(w/(2*pi),20*log10(mag1),'linewidth',2,DisplayName='3° ordem - caso 1 (R>Rc)')%plota magnitude
semilogx(w/(2*pi),20*log10(mag2),'linewidth',2,DisplayName='3° ordem - caso 2 (R<Rc)')%plota magnitude
semilogx(w/(2*pi),20*log10(mag3),'linewidth',2,DisplayName='3° ordem - caso 3 (R=Rc)')%plota magnitude
grid on %ativa linhas do grid no gráfico
hold on %ativa multiplas curvas no mesmo gráfico
xlabel('Frequência (Hz)') %label do eixo x
ylabel('Magnitude (dB)') %label do eixo y
title('Magnitude') %titulo do grafico 
legend('Location','best')
subplot(2,1,2) %define subfigura 2
hold on
semilogx(w/(2*pi),pha0,'linewidth',2,'DisplayName','Integrador') %plota fase
semilogx(w/(2*pi),pha1,'linewidth',2,'DisplayName','3° ordem - caso 1 (R>Rc)') %plota fase
semilogx(w/(2*pi),pha2,'linewidth',2,'DisplayName','3° ordem - caso 2 (R<Rc)') %plota fase
semilogx(w/(2*pi),pha3,'linewidth',2,'DisplayName','3° ordem - caso 3 (R=Rc)') %plota fase
grid on %ativa linhas do grid no gráfico
hold on %ativa multiplas curvas no mesmo gráfico
xlabel('Frequência (Hz)') %label do eixo x
ylabel('Fase (°)') %label do eixo y
title('Fase') %titulo do grafico
legend('Location','best')
%% bode do circuito RLC
figure
subplot(2,1,1) %define subfigura 1
hold on
semilogx(w/(2*pi),20*log10(mag2_1),'linewidth',2,DisplayName='2° ordem - caso 1 (R>Rc)')%plota magnitude
semilogx(w/(2*pi),20*log10(mag2_2),'linewidth',2,DisplayName='2° ordem - caso 2 (R<Rc)')%plota magnitude
semilogx(w/(2*pi),20*log10(mag2_3),'linewidth',2,DisplayName='2° ordem - caso 3 (R=Rc)')%plota magnitude
grid on %ativa linhas do grid no gráfico
hold on %ativa multiplas curvas no mesmo gráfico
xlabel('Frequência (Hz)') %label do eixo x
ylabel('Magnitude (dB)') %label do eixo y
title('Magnitude') %titulo do grafico 
legend('Location','best')
subplot(2,1,2) %define subfigura 2
hold on
semilogx(w/(2*pi),pha2_1,'linewidth',2,'DisplayName','2° ordem - caso 1 (R>Rc)') %plota fase
semilogx(w/(2*pi),pha2_2,'linewidth',2,'DisplayName','2° ordem - caso 2 (R<Rc)') %plota fase
semilogx(w/(2*pi),pha2_3,'linewidth',2,'DisplayName','2° ordem - caso 3 (R=Rc)') %plota fase
grid on %ativa linhas do grid no gráfico
hold on %ativa multiplas curvas no mesmo gráfico
xlabel('Frequência (Hz)') %label do eixo x
ylabel('Fase (°)') %label do eixo y
title('Fase') %titulo do grafico
legend('Location','best')