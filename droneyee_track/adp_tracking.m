function [ux1,uy1,delta_,omega_,dW_,test] = adp_tracking(P_feedback1,p_virtual1,Joystick,delta_his,omega_his,W,t,dP_feedback1,lcoa)
% the parameter of 'approaching'

% P_wp1=[10;30];  % target location

sampleTime = 1/25;
g = 9.8;
A = zeros(2);
B = eye(2)/g;
% B = [zeros(2);eye(2)]/g;
Q = 100*eye(2);
R = 200*eye(2);
% R = 500*eye(2);

l = length(W);

dx = dP_feedback1;
% dx = u;

%% ADP Path Planning

% x = P_feedback1 - P_wp1;
x = P_feedback1 - p_virtual1;
x1 = x(1); x2 = x(2);
% phi = [x1^2;x1*x2;x2^2];
% dphi = [2*x1 0; x2 x1; 0 2*x2];
[sig,sig_p] = Staf_Basis(x); % State-following NN basis
dphi = sig_p;
test = norm(dphi);


%% update
% W = 1*[30.7119   42.8391  115.4889]';
umax = 1;
u_adp = -umax*tanh(0.5/umax*R\B'*dphi'*W);
% u_adp = -0.5*R\B'*dphi'*W;
u_safe = -0.5*R\B*lcoa;
u_adp = u_adp + u_safe;% + u_human;
% u_adp = -0.5*R\B'*dphi'*W;
% u_adp = lambda * u_adp + (1-lambda) * u_safe;
% K_lqr = [0.7071 0.0000; 0.0000 0.7071]*2;
% u_adp = -K_lqr*x;

if t > 10
%     u = u_adp;
%     u = -0.5*R\B'*dphi'*W;
    u = -umax*tanh(0.5/umax*R\B'*dphi'*W);
else
    u = zeros(2,1);
end
%% ADP nn

omega = dphi*dx;
delta = W'*omega + x'*Q*x + u'*R*u;
rou = 1 + omega'*omega;
delta_ = [delta_his(2:end,:); delta];
omega_ = [omega_his(2:end,:); omega'];

%% Concurrent learning
con_flag = 0;
if con_flag == 1 && t>10
    temp = zeros(l,1);
    for i = 1:length(delta_his)
        omega = omega_(i,:);
        delta = delta_(i,:);
        rou = 1 + omega*omega';
        temp = temp - 0.01*omega'./rou^2*delta; 
    end
    dW_ = temp;
elseif t>10
        dW_ = - 1*omega*delta/rou; 
else
        dW_ = zeros(l,1);
end
%% 输出
% u_adp = u;
ux1 = u_adp(1);
uy1 = u_adp(2);



