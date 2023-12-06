% Ogata Example 9-1
% Lead compensation design
clear all
% uncompensated system
num_u1 = 2;
den_u1 = [1/2 1 0];
Gu1 = tf(num_u1,den_u1);
% Step 1: find K to satisfy required static error constant
K = 10;
num_u2 = 2*K;
den_u2 = [1/2 1 0];
Gu2 = tf(num_u2,den_u2);

% Step 2: find the gain crossover frequency
numg = 2*K;
% magnitude function for finding wg at 0 dB
% f = 2*K - x*sqrt(0.25*x^2+1)
wg = fsolve(@(x) 2*K - x*sqrt(0.25*x^2+1),0.1) %,optimoptions('fsolve','Display','iter'))
% phase at wg in degrees
phig = 0-90-atan(0.5*wg)*180/pi
% phase margin in degrees
gamma = 180 + phig

% Step 3: determine necessary phase lead angle phi_m
% Rationale: want at least 50 degrees
phi_m = 50 - gamma
% add extra due to shifting of the crossover frequency
phi_m = phi_m + 6

% Step 4: find alpha and the new gain crossover frequency
alpha = (1-sin(phi_m*pi/180))/(1+sin(phi_m*pi/180))

% Find frequency where uncompensated system is equal to 
% -20*log10(1/sqrt(alpha)); this is new crossover frequency
% New gain crossover
afac = -20*log10(1/sqrt(alpha)) % in dB
afacm = 10^(afac/20)
wm = fsolve(@(x) 2*K - afacm*x*sqrt(0.25*x^2+1),0.1);
% Step 5: determine corner frequencies
% solve for T
T = 1/sqrt(alpha)/wm
alpha*T
% corner frequencies
w1 = 1/T
w2 = 1/alpha/T
% Compensator
num_c = [1/w1 1];
den_c = [1/w2 1];
Gc = tf(num_c,den_c);
GcGu2 = series(Gc,Gu2);
figure(3)
bode(Gu2,GcGu2,Gc), legend('Uncompensated','Compensated','G_c')
% Step response
Gu1_cl = feedback(Gu1,1); % no gain, no compensation
GcGu2_cl = feedback(GcGu2,1);
figure(4)
step(Gu1_cl,GcGu2_cl), legend('Uncompensated','Compensated')

% Ramp response
[numu1_cl,denu1_cl]=tfdata(Gu1_cl,'v');
denu1_clr = [denu1_cl 0];
Gu1_clr = tf(numu1_cl,denu1_clr);
[numc_cl,denc_cl]=tfdata(GcGu2_cl,'v');
denc_clr = [denc_cl 0];
Gc_clr = tf(numc_cl,denc_clr);

figure(5)
[yur,tur] = step(Gu1_clr,5); % this is ramp response
[ycr,tcr] = step(Gc_clr,5); % this is ramp response

plot(tur,tur,tur,yur,tcr,ycr)
legend('ramp input','uncompensated','compensated')

