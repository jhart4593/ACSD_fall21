%Find unit step, impulse, and ramp responses of three different systems and
%compare 

%unit ramp response - use step function and multiply transfer function by
%1/s
num1 = [0 0 0 5];
den1 = [5 1 5 0];
sys1 = tf(num1, den1);

num2 = [0 0 4 5];
den2 = [5 5 5 0];
sys2 = tf(num2, den2);

num3 = [0 0 0 5];
den3 = [5 5 5 0];
sys3 = tf(num3, den3);

step(sys1)
title('Ramp Response')
hold on
step(sys2)
step(sys3)
legend('Sys1', 'Sys2', 'Sys3')
ylim([0 5])
xlim([0 7])
hold off