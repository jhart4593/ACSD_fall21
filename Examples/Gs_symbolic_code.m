syms s C1 R1 C2 R2

n = 2;

A = [-1/(C1*R1) 1/(C2*R2);-1/(C1*R1) -1/(C2*R2)];
B = [1/R1; 0];
C = [0 1/C2];
D = 0;

G = C*inv(s*eye(n)-A)*B+D;
G = collect(simplify(G),s);

pretty(G)
