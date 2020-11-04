M = 0.195;    % Mass of cart (Kg)
m = 0.2;    % Mass of pendulum(Kg) original 0.18
b = 0.5;    % Co-efficient of Friction(N*sec/m)
l = 0.22;    % length of pendulum(m) original 0.21
g = 9.8;    % gravity (m/sec^2) 
I = (m*l^2)/3;  % Moment of inertia(Kg*m^2)
F = 0;      % Force Applied(N)
x = 0;      % Cart position
X0 = [0 0 pi 0.1]';
X_d = [0 0 0 0]';
Ts = 1/100;
Current_saturation=2000; % 1000 mAmp
N_to_mAmp = 260;
Theta = 0;  % Pendulum angle from Vertical down position

%% Linearized Continious open-loop State-space System 

p = I*(M+m) + M*m*l^2; %denominator for the state space

A = [   0       1               0           0;
        0   -(I+m*l^2)*b/p  (m^2*g*l^2)/p   0;
        0       0               0           1;
        0   -(m*l*b)/p      m*g*l*(M+m)/p   0];
    
B = [   0;
    (I+m*l^2)/p;
        0;
      m*l/p  ];

C = [1   0   0   0;
     0   0   1   0];
    
D = [0;
     0];
 
states = {'x' 'x_dot' 'phi' 'phi_dot'};
inputs = {'u'};
outputs = {'x'; 'phi'};
sys = ss(A,B,C,D,'statename',states,'inputname',inputs,'outputname',outputs);
%step(sys)
%% Linearized Continious closed-loop State-space System

Q = C'*C;
Q(1,1) = 5000;  % working 5000  position
Q(2,2) = 0;
Q(3,3) = 2000;  % wokring 1000  angle
Q(4,4) = 0;
R = 0.4 ;        % working 0.1   force

% 5000,2000,0.5 slow response smaller oscil water good Ts 100
% 5000,2000,0.5 " " Medium osci Ts 200 water good

K = lqr(A,B,Q,R);

Ac = [(A-B*K)];
Bc = [B];
Cc = [C];
Dc = [D];
eig_Ac = eig(Ac)
sys_cl = ss(Ac,Bc,Cc,Dc,'statename',states,'inputname',inputs,'outputname',outputs);
Nc = 1/dcgain(sys_cl(1));
sys_cl = ss(Ac,Bc*Nc,Cc,Dc,'statename',states,'inputname',inputs,'outputname',outputs);
%figure; step(sys_cl)
%% Linearized Continious closed-loop Observer based State-space System

%P = [-15 -16 -17 -14];
P = [-35 -36 -37 -38];
L = place(A',C',P)';

Ace = [(A-B*K) (B*K);
       zeros(size(A)) (A-L*C)];
Bce = [B*Nc;
       zeros(size(B))];
Cce = [Cc zeros(size(Cc))];
Dce = [0;0];

states = {'x' 'x_dot' 'phi' 'phi_dot' 'e1' 'e2' 'e3' 'e4'};
inputs = {'r'};
outputs = {'x'; 'phi'};

sys_est_cl = ss(Ace,Bce,Cce,Dce,'statename',states,'inputname',inputs,'outputname',outputs);
%step(sys_est_cl)

%% Linearized discreat closed-loop State-space System
sys_d = c2d(sys,Ts,'zoh');

Ad = sys_d.a;
Bd = sys_d.b;
Cd = sys_d.c;
Dd = sys_d.d;

Kd = dlqr(Ad,Bd,Q,R)
Adc = [(Ad-Bd*Kd)];
Bdc = [Bd];
Cdc = [Cd];
Ddc = [Dd];

states = {'x' 'x_dot' 'phi' 'phi_dot'};
inputs = {'r'};
outputs = {'x'; 'phi'};

sys_d_cl = ss(Adc,Bdc,Cdc,Ddc,Ts,'statename',states,'inputname',inputs,'outputname',outputs);
Ndc = 1/dcgain(sys_d_cl(1));
sys_d_cl = ss(Adc,Bdc*Ndc,Cdc,Ddc,Ts,'statename',states,'inputname',inputs,'outputname',outputs);
%step(sys_d_cl)

%% Linearized discreat closed-loop Observer State-space System
Pd = [ pole(sys_d_cl)/3]
Ld = place(Ad',Cd',Pd)';


Adce = [(Ad-Bd*Kd) (Bd*Kd);
       zeros(size(Ad)) (Ad-Ld*Cd)];
Bdce = [Bd*Ndc;
       zeros(size(Bd))];
Cdce = [Cdc zeros(size(Cdc))];
Ddce = [0;0];

states = {'x' 'x_dot' 'phi' 'phi_dot' 'e1' 'e2' 'e3' 'e4'};
inputs = {'r'};
outputs = {'x'; 'phi'};

sys_d_est_cl = ss(Adce,Bdce,Cdce,Ddce,Ts,'statename',states,'inputname',inputs,'outputname',outputs);
%figure;step(sys_d_est_cl)



