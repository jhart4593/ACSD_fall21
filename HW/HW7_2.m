% num = [0 0 1];
% den = [1 0 0];
% sys = tf(num,den);
% bode(sys)



num = [0 0 50 200];
den = [1 1 0 0];
sys = tf(num,den);
bode(sys)