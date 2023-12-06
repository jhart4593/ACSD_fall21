function xdot = inverted_pendulum_n(t,x)
global M m l g Kp Kd Fno
x_m = x(1);
xdot_m = x(2);
thetao = x(3);
thetaod = x(4);
% linear controller, PD
Fc = Kp*(thetao+Kd*thetaod);
Fn = Fno*sin(2*pi*0.5*t);
F = Fc + Fn;
xdot1 = xdot_m;
xdot2 = -1/(-M-m+m*cos(thetao)^2)*(m*l*sin(thetao)*thetaod^2+F)+cos(thetao)/(-M-m+m*cos(thetao)^2)*m*g*sin(thetao);
xdot3 = thetaod;
xdot4 = cos(thetao)/l/(-M-m+m*cos(thetao)^2)*(m*l*sin(thetao)*thetaod^2+F)-(M+m)/l/(-M-m+m*cos(thetao)^2)*g*sin(thetao);
xdot = [xdot1;xdot2;xdot3;xdot4];