num = [0 0 10];
den = [.25 1 0];
sys = tf(num,den);
bode(sys)