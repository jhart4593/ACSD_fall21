% Initial condition response of three-state system
% rgl 12-2-21
clear all

A = [0,-1,0;1,0,-1;0,1,0];
%B = [+1,0;0,0;0,-1];
B = [0;0;-1];
C = [1,0,0];
D = [0];

% uncontrolled system
sysu = ss(A,B,C,D);
[yu,tu,xu] = initial(sysu,[1;0;0.5],5);

% desired poles
zeta = 0.707; wn = 3;
p = roots(conv([1,2*zeta*wn,wn*wn],[1,zeta*wn]))
K = place(A,B,p) % should have proven controllability

Ac = A-B*K;
Bd = [0;0;0]; % no disturbance
Cc = C-D*K;
Dc = 0;

sysc = ss(Ac,Bd,Cc,Dc);

[yc,tc,xc] = initial(sysc,[1;0;0.5],5);

for i = 1:length(xc)
    uc(i) = -K*xc(i,:)'; % controller output
end

figure(1)
subplot(2,2,1), plot(tu,xu(:,1),tu,xu(:,3))
legend('y=x_1 (no FB)','x_3 (no FB)')
title('uncontrolled IC response')
subplot(2,2,3), plot(tu,xu(:,2))
legend('x_2 (no FB)')
subplot(2,2,2), plot(tc,xc(:,1),tc,xc(:,3))
legend('y=x_1 (FB)','x_3 (FB)')
title('full-state feedback IC response')
subplot(2,2,4), plot(tc,xc(:,2),tc,uc)
legend('x_2 (FB)','uc=-Kx')
