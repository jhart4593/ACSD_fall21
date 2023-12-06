%
% Inverted Pendulum Problem
%
clear all
global M m l g Kp Kd Fno
M = 1000; m = 200; l = 10;
g = 9.81;
Kp = 14204;
Kd = 0.491; % seconds
Fno = 0;

tspan = [0 20]
x0 = [0;0;.1;0];
[t,x] = ode45(@inverted_pendulum,tspan,x0);
[tn,xn] = ode45(@inverted_pendulum_n,tspan,x0);

figure(1)
subplot(2,2,1), plot(t,x(:,3)*180/pi,tn,xn(:,3)*180/pi), title('Angle (deg)')
subplot(2,2,2), plot(t,x(:,1),tn,xn(:,1)), title('Position (m)')
subplot(2,2,3), plot(t,Kp*(x(:,3)+Kd*x(:,4)),tn,Kp*(xn(:,3)+Kd*xn(:,4))), title('Control Force (N)')
subplot(2,2,4), plot(t,Kp*(x(:,3)+Kd*x(:,4)).*x(:,2)), title('Power (W)')
