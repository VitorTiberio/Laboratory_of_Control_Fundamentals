close all
clear all
clc
s=tf('s');
%% sistema de 1ordem
R=6.8e3; %valor do resistor
C=22e-09; %valor do capacitor
K=1; %ganho estático do sistema
A=0.5; %amplitude pico a pico do sinal de entrada
Grc=tf([K],[R*C 1]) %define função de transferencia no formato G(s)=num/den
%% RLC - caso 1 (R=Rc)
L=590e-3; %valor da indutancia
C=69e-09; %valor do capacitor
wn=1/sqrt(L*C);
Rc=2*L*wn;
R=Rc; %valor do resistor do RLC
xi=R/(2*L*wn);
Grlc=tf([wn^2],[1 2*xi*wn wn^2]); %define função de transferencia no formato G(s)=num/den
%%
G=Grc*Grlc
%rlocfind(G)
figure(1)
hold on
rlocus(G,'b')
Kmax=margin(G)
%%
figure(2)
hold on
nyquist(G)
title('Diagrama de Nyquist')
figure(3)
hold on
margin(G)
title('Bode')
%%
figure(4)
dt=1e-6;
t=0:dt:5e-3;
T=feedback(Kmax*G,1);
[y,t]=step(T,t);
plot(t*1000,y,'LineWidth',2,DisplayName='saída')
hold on
plot(t*1000,ones(size(t)),'k--','linewidth',2,DisplayName='referencia')
xlabel('Tempo (ms)')
ylabel('Saída (volts)')
legend('Location','best')
grid on
%% RLC - caso 2 (R=2Rc)
L=590e-3; %valor da indutancia
C=69e-09; %valor do capacitor
wn=1/sqrt(L*C);
Rc=2*L*wn;
R=2*Rc; %valor do resistor do RLC
xi=R/(2*L*wn);
Grlc=tf([wn^2],[1 2*xi*wn wn^2]); %define função de transferencia no formato G(s)=num/den
%%
figure(1)
G=Grc*Grlc
%rlocfind(G)
rlocus(G,'r')
%legend('R=R_c','R=2R_c','')
Kmax=margin(G)
%%
figure(2)
nyquist(G)
title('Diagrama de Nyquist')
legend('R=R_c','R=2R_c')
figure(3)
margin(G)
title('Bode')
%%
figure(4)
dt=1e-6;
t=0:dt:5e-3;
T=feedback(Kmax*G,1);
[y,t]=step(T,t);
plot(t*1000,y,'LineWidth',2,DisplayName='saída')
hold on
plot(t*1000,ones(size(t)),'k--','linewidth',2,DisplayName='referencia')
xlabel('Tempo (ms)')
ylabel('Saída (volts)')
legend('Location','best')
grid on
%%
