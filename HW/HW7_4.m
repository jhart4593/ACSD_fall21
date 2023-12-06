K = 0.266;

num = [0 0 10*K K];
den = [1 1.5 0.5 0];
sys = tf(num,den);
bode(sys)