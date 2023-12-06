%PFE of step response 
num = [0 0 0 50];
den = [1 10 100 0];

[r,p,k] = residue(num,den)

%Plot Step Response
num1 = [0 0 100];
den1 = [1 10 100];

tf1 = tf(num1,den1);

opt = stepDataOptions('StepAmplitude',1/2);

[y,x] = step(tf1,opt);
y1 = y + y.*sqrt(10);

plot(x,y1)

