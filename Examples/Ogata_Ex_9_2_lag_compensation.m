% Ogata Example 9-2
% Lag compensation design
clear all
% uncompensated system
% syms s; collect(expand(s*(s+1)*(0.5*s+1),s)
% 
% s^3/2 + (3*s^2)/2 + s
num_u1 = 1;
den_u1 = [1/2 3/2 1 0];
Gu1 = tf(1,den_u1);
% Step 1: gain to meet specification
K = 5;
Gu2 = tf(K,den_u1);
figure(1)
bode(Gu1,Gu2)
% Step 2: if specs not met (as in this case)
% find phase margin
% Note: Ogata says the phase margin is -20, but
% I get -13 dB (also graphically from bode plots)
wg = fsolve(@(x) 5-(x*sqrt(x^2+1)*sqrt(x^2/4+1)),0.1)
phig = -90-atan(wg)*180/pi-atan(0.5*wg)*180/pi
gamma = 180 + phig % phase margin in degrees
% See rationale (in Ogata)
% Now, want freq where uncompensated system gives
% the desired/required phase margin
% A lag compensator modifies the phase, so need to allow
% from 5 to 12 degrees in the specified phase margin to compensate
% for this modification. The specifications call for 40 deg
% NOTE: Ogata works as follows
% The uncompensated phase (with K) gives a margin of 40 deg
% at w = 0.63 rad/sec (Ogata says at 0.7 rad/sec).
% Ogata initially chooses 0.1 rad/sec for -1/T, but then
% mentions you can add more phase in case
% it is modified too much by phase, so adds 12 deg to spec
% making it 52 deg; so 180 - 52 = 128; 
% this occurs for the uncompensated G at 0.46 Hz.
% So, makes wg_new = 0.5
% Here is computational approach
phi_ud = -180 + abs(gamma) + 39 % adjust to get about 52
% solve for new crossover freq from phase function
% or find graphically using Bode plot
wg_new = fsolve(@(x) phi_ud*pi/180+pi/2+atan(x)+atan(0.5*x),0.1)
% Step 3. Choose first corner frequency w1 = 1/T (zero)
% to be about 1 decade below wg_new
% corner frequencies
w1 = 0.1*wg_new 
T = 1/w1
% Step 4. Determine beta (attenuation) to bring the
% magnitude at wg_new to 0 dB. The uncompensated G gives,
Gu_wg_new = 5/wg_new/sqrt(wg_new^2+1)/sqrt(wg_new^2/4+1)
% and this is how much you need to drop magnitude
% 20*log10(1/beta) = -20*log10(Gu_wg_new)
% Use this to solve for beta
beta = 1/10^(-20*log10(Gu_wg_new)/20)
% originally from Ogata: beta = 1/10^(-20/20)
% Now the other corner frequency can be found:
w2 = 1/beta/T
% Step 5. The gain used in Step 2 and beta can be used to find
% the constant Kc if it is used
Kc = K/beta
% Define compensator
num_c = [T 1];
den_c = [beta*T 1];
Gc = tf(num_c,den_c);
% Compensated system
GcGu2 = series(Gc,Gu2);

figure(2)
bode(Gu2,GcGu2), legend('Uncompensated','Compensated')
 
Gu1_cl = feedback(Gu1,1);
GcGu2_cl = feedback(GcGu2,1);
% 
figure(3)
step(Gu1_cl,GcGu2_cl,40)
legend('Uncompensated - no gain','Compensated')
