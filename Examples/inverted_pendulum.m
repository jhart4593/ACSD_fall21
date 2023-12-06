function xdot = inverted_pendulum(t,x)
global M m l g Kp Kd Fno
x_m = x(1);
xdot_m = x(2);
thetao = x(3);
thetaod = x(4);
% linear controller, PD
Fc = Kp*(thetao+Kd*thetaod);
% dynamic force disturbance
Fn = Fno*sin(2*pi*0.5*t);
F = Fc + Fn;
xdot1 = xdot_m;
xdot2 = 1/M*F-1/M*m*g*thetao;
xdot3 = thetaod;
xdot4 = -1/l/M*F+(M+m)/l/M*g*thetao;
xdot = [xdot1;xdot2;xdot3;xdot4];