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
for i=1:N
R=Rs(i); %valor do resistor
xi=R/(2*L*wn);
G2=tf([wn^2],[1 2*xi*wn wn^2]); %define função de transferencia no formato G(s)=num/den
%% polos
p2(:,i)=pole(G2);
end
%% plot
figure(1),hold on,grid on
plot(real(p1),imag(p1),'xr','LineWidth',2,DisplayName='Integrador')
plot(real(p2),imag(p2),'xb','LineWidth',2,DisplayName='RLC')
line([real(p1) real(p1)],[-6000 6000],'linestyle','--','color','k')
line([real(p1)*10 real(p1)*10],[-6000 6000],'linestyle','--','color','k')
xlim([-15000 100])
xlabel('\sigma (parte real)')
ylabel('j\omega (parte imaginária)')
legend('Pólo do Integrador','Pólos do RLC','Location','best')
title('Plano-s')
