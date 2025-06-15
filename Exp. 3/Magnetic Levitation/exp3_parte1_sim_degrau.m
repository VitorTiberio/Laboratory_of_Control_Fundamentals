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
%% resposta ao degrau
dt=1e-6;
t=0:dt:30e-3;
% caso 1 (R>Rc)
R=2*Rc; %valor do resistor do RLC
xi=R/(2*L*wn);
G2=tf([wn^2],[1 2*xi*wn wn^2]); %define função de transferencia no formato G(s)=num/den
y2_1=step(G2,t);
G=G1*G2 %integrador em serie com RLC
y_1=step(G,t); %resposta do sistema de 3° ordem
% caso 2 (R<Rc)
R=1/2*Rc; %valor do resistor do RLC
xi=R/(2*L*wn);
G2=tf([wn^2],[1 2*xi*wn wn^2]); %define função de transferencia no formato G(s)=num/den
y2_2=step(G2,t);
G=G1*G2 %integrador em serie com RLC
y_2=step(G,t); %resposta do sistema de 3° ordem
% caso 3 (R=Rc)
R=Rc; %valor do resistor do RLC
xi=R/(2*L*wn);
G2=tf([wn^2],[1 2*xi*wn wn^2]); %define função de transferencia no formato G(s)=num/den
y2_3=step(G2,t);
G=G1*G2 %integrador em serie com RLC
y_3=step(G,t); %resposta do sistema de 3° ordem
%% plot
figure
y1=step(G1,t); %resposta ao degrau do integrador
hold on
plot(t*1000,y1,'DisplayName','Integrador',LineWidth=1.5)
plot(t*1000,y2_1,'DisplayName','RLC (R>R_c)',LineWidth=1.5)
plot(t*1000,y_1,'DisplayName','3° ordem',LineWidth=1.5)
plot(t*1000,ones(size(t)),'k--',DisplayName='Referência',LineWidth=1.5)
grid on
xlabel('tempo (ms)')
ylabel('Saída (volts)')
legend('Location','best')
title('Caso 1')
figure
hold on
plot(t*1000,y1,'DisplayName','Integrador',LineWidth=1.5)
plot(t*1000,y2_2,'DisplayName','RLC (R<R_c)',LineWidth=1.5)
plot(t*1000,y_2,'DisplayName','3° ordem',LineWidth=1.5)
plot(t*1000,ones(size(t)),'k--',DisplayName='Referência',LineWidth=1.5)
grid on
xlabel('tempo (ms)')
ylabel('Saída (volts)')
legend('Location','best')
title('Caso 2')
figure
hold on
plot(t*1000,y1,'DisplayName','Integrador',LineWidth=1.5)
plot(t*1000,y2_3,'DisplayName','RLC (R=R_c)',LineWidth=1.5)
plot(t*1000,y_3,'DisplayName','3° ordem',LineWidth=1.5)
plot(t*1000,ones(size(t)),'k--',DisplayName='Referência',LineWidth=1.5)
grid on
xlabel('tempo (ms)')
ylabel('Saída (volts)')
legend('Location','best')
title('Caso 3')
%%

