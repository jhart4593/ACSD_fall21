num = [0 0 0 2.5];
den = [1 11 10 0];
sys = tf(num,den);
bode(sys)