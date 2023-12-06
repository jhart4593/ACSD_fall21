%PFE  
% num = [0 0 1 1];
% den = [1 11 0 0];
% 
% [r,p,k] = residue(num,den)

%Plot Step Response of step response of error function - this gives ramp
%response
num1 = [0 1 3.16];
den1 = [1 13.16 0];

tf1 = tf(num1,den1);

step(tf1);