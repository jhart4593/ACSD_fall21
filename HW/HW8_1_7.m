num = [0 0 0 10];
den = [1 6 5 0];

G1 = tf(num,den);

numc = [.513 1];
denc = [.088 1];

Gc = tf(numc,denc);

GcGc = series(Gc,Gc);

G1GcGc = series(G1,GcGc);

% bode(G1,G1GcGc)

numr = [0 1];
denr = [1 0];
ramp = tf(numr,denr);

cl1 = feedback(G1,1);
clc = feedback(G1GcGc,1);

rampG1 = series(cl1,ramp);
rampG1GcGc = series(clc,ramp);

step(rampG1,rampG1GcGc,ramp)
legend('uncompensated','compensated')
xlim([0 20])
ylim([0 20])
