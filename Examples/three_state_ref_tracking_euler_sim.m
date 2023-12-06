% Simulation of the generic 3-state system
% Use of the internal model form for reference
% input tracking (Ref. Dorf & Bishop, Section 11.8, or
% integral action in Astrom & Murray, Section 7.4)
% rgl, 12/7/21

% This simulation uses an Euler simulation approach
% For Euler simulation, consider an ODE
%
% dx/dt = f(x,u) (nonlinear case)
% dx/dt = Ax + Bu (linear case)
%
% You can approximate the solution at a step i by:
% x(i) = x(i-1) + f(x(i-1),u(i-1))*dt
% where x(i-1) is the initial or previous value and
% dt is the time step. 

% For Euler sim, usually you need
% pretty small dt down to 1e-4 to 1e-6, depending on
% the system dynamics.
%
% Euler sim can be readily implemented in a basic
% for loop.
%
% It is also possible to set up a simulation with RK4 
% solvers, which are more robust and stable, but
% as long as you can deal with longer simulation times
% an Euler is ok (and maybe easier to understand).
%
% Why do we need an Euler approach here?
% Typically, we can use the linear simulation tools in Matlab.
% These include initial(), impulse(), step(), and lsim(), which
% all allow you to define either a state-space or TF model
% (initial only allows ss).
% However, if you want to specify a reference input and
% especially one that can change over time then it is not
% clear how to use those 'one line commands' to get a
% simulation. By composing an Euler (or RK4) simulation,
% you can define and integrate the reference input.
% One way to do this is illustrated in this example.
%

clear all

% Construct the open-loop system 
% This is the 3-state system from lecture example
A = [0,-1,0;1,0,-1;0,1,0];
B = [0,1;0,0;-1,0]; % inputs are uc and ud (disturbance)
% however, not using the disturbance in this example
C = [1,0,0]; % single-output state  y = x1
D = [0];

% This design uses an internal model (IM)
% Reference Dorf & Bishop, section 11.8
% for IM form (see eq. 11.81 in Dorf & Bishop)
Aim = [0,C;zeros(3,1),A]; Bim = [0;B(:,1)];
% NOTE that the IM only uses the 1st column of B
% for the control input
% The second input is a disturbance, ud

% Form internal model controllability matrix
Pimc = ctrb(Aim,Bim);
% confirm system is completely controllable; det(Pc) not zero
det(Pimc) % should be nonzero

% Select poles for IM 
% adjust to get desired/better performance
% These values are somewhat arbitrary:
p = [-1+j*0.8,-1-j*0.8,-8,-6];
% select gains
K = place(Aim,Bim,p)

% Simulation parameters
% NOTE: Euler simulation generally needs very small
% time steps, so begin with dt = 1e-4. 
% Adjust dt as needed to get good response
% If dt is too small, you may get divergent response
% (but divergent response also sometimes means you have
% an incorrect model, a type, etc.; debugging is key)
dt=0.0001;       % time interval for fixed-step simulation
t0 = 0.0;       % start time
tf = 50;        % final time
N = floor((tf-t0)/dt); % number of steps

% Now, set up the vectors needed
% fill them initially with zeros
tc = zeros(1,N); % time
xc = zeros(3,N); % the three states (in this case)
uc = zeros(1,N); % control input
z = zeros(3,N); % the z values (ref. D&B, Section 11.8)
r = zeros(1,N); % reference input (a scalar)
y = zeros(1,N); % output (a scalar defined by C)
e = zeros(1,N); % error = y - r

% Now define initial values at t = 0
tc(1) = 0;
% define the initial conditions for simulation
% NOTE: here the initial state of the plant 
% satisfies equilibrium
xo = [1;0;1];   % plant initial states
xc(:,1) = xo; % these are the original states
uc(1) = 0; % initial control output is zero here

% initialize z; z = xdot, so zo comes from xdoto
% See Dorf & Bishop to see definition of z
z(:,1) = A*xc(:,1) + B(:,1)*uc(1); 

y(1) = C*xo; % initial output
r(1) = y(1); % make initial reference at initial y
e(1) = y(1) - r(1); % initial error

for i = 2:N
    tc(i) = tc(i-1) + dt;
    if (tc(i)>1 && tc(i)<10)
        r(i) = r(1) + 0.25;
    elseif tc(i)>=10 && tc(i)<30
        r(i) = r(1) - 0.5;
    elseif tc(i)>=30 && tc(i)<40
        r(i) = r(1) + 0.25;
    else
        r(i) = r(1);
    end
    y(i) = C*xc(:,i-1);
    e(i) = y(i) - r(i);
    
    de(i) = C*z(:,i-1);
    dz(:,i) = -B(:,1)*K(1)*e(i) + (A-B(:,1)*K(2:4))*z(:,i-1);
    duc(i) = -K(1)*e(i) - K(2:4)*z(:,i-1);
    dxc(:,i) = A*xc(:,i-1) + B(:,1)*uc(i-1);
    
    %e(i) = e(i-1) + de(i)*dt;
    z(:,i) = z(:,i-1) + dz(:,i)*dt;
    uc(i) = uc(i-1) + duc(i)*dt;
    xc(:,i) = xc(:,i-1) + dxc(:,i)*dt;

end

% Plotting
figure(1)
subplot(4,1,1), plot(tc,e), legend('e = y-r')
subplot(4,1,2), plot(tc,uc), legend('uc')
subplot(4,1,3), plot(tc,r,tc,xc(1,:),tc,xc(3,:))
legend('r','x_1','x_3')
ylim([0,1.5])
subplot(4,1,4), plot(tc,xc(2,:)), legend('x_2')
ylim([-0.5,0.5])








