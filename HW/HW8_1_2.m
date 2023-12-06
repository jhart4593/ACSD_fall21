% num = [0 0 0 5];
% den = [.2 1.2 1 0];
% 
% bode(num,den)

wc = fsolve(@(x) 5/(x*sqrt(x^2+1)*sqrt(.04*x^2+1))-.414,0.1)
