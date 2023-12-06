%PFE of G(s)* unit step (1/s)
clc
clear

num1 = [0 0 2/3 2/9];
den1 = [1 2/3 2/9 0];

[r,p,k] = residue(num1,den1);

%Plot step of the transfer function vs analytical solution

num2 = [0 2/3 2/9];
den2 = [1 2/3 2/9];

sys = tf(num2, den2);

t = [0:0.25:15];
c_t = 1-exp(-t/3).*cos(t/3)+exp(-t/3).*sin(t/3);

step(sys)
hold on
plot(t,c_t,'ro')
ylim([0 1.25])
legend('MATLAB','Analytical Soln')
hold off