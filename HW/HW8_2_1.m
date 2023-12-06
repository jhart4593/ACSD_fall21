k = 110;
num = [0 0 0 k];
den = [1 13 40 0];
G1 = tf(num,den);

G1cl = feedback(G1,1);

step(G1cl)