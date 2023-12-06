%PFE of G(s)* unit step (1/s)

num1 = [0 0 0 4];
den1 = [1 5 4 0];

[r,p,k] = residue(num1,den1);

%Plot step of the transfer function vs analytical solution

num2 = [0 0 4];
den2 = [1 5 4];

sys = tf(num2, den2);

t = [0:0.25:7];
c_t = 1/3*exp(-4*t)-(4/3)*exp(-t)+1;

step(sys)
hold on
plot(t,c_t,'ro')
ylim([0 1.25])
legend('MATLAB','Analytical Soln')
hold off
