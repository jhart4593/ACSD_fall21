num = [0 0 0 548];
den = [1 13 40 0];

G1 = tf(num,den);

numc = [5 1];
denc = [32.8 1];

Gc = tf(numc,denc);

GcG1 = series(Gc,G1);

bode(GcG1,G1)
legend('compensated','uncompensated')
