%PFE 

num1 = [0 1 7 30];
den1 = [2 10 12 0];

[r,p,k] = residue(num1,den1)

%Plot step of the transfer function vs analytical solution

num2 = [1 7 30];
den2 = [2 10 12];

sys = tf(num2, den2);

t = [0:0.25:7];
c_t = 3*exp(-3*t)-5*exp(-2*t)+2.5;

step(sys)
hold on
plot(t,c_t,'ro')
ylim([0 2.75])
legend('MATLAB','Analytical Soln')
hold off