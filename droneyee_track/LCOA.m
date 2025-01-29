function [y,Cache1] = LCOA(X)
P_wp1=[10;30];  % target location

% x = X(1:2)-P_wp1;
x = X(1:2);
ro = 0.2;
ra = ro * 1.5;
rd = ro * 2;
L1 = 0.3; L2 = 0.8; L3 = 0.2;

% zk_ = [10 18; 18 18]-[P_wp1';P_wp1'];
% zk_ = [9-0.5 15; 17-0.5 15];
% zk_ = [9-1 15; 17-1 15];
% zk_ = [9-2 15; 17-2 15];
% zk_ = [1 15; 9 15];
% zk_ = [1.5 15; 8.5 15];
% zk_ = [2 15; 8 15];
% zk_ = [3 12; 7 18];
% zk_ = [3+0.5 15; 9 15];
% zk_ = [9 10; 11.5 25];
% zk_ = [10.5 15; 11.5 25];
zk_ = [-1.8 -0.6; -0.8 0.5];

s = 0; ds = [0;0];
beta = 0; dbeta = [0;0];

for i = 1:length(zk_)
    zk = zk_(i,:)';
    dk = norm(x-zk);
    ddk = (x-zk)/dk;
    betak = dk - ro;
    dbetak = ddk;
    
    if dk > rd
        sk = 0;
        dsk = [0;0];
    elseif dk >ra
        sk = L1 + L1 * cos(pi*(dk^2 - ra^2)/(rd^2 - ra^2));
        dsk = -2*pi*dk*ddk*sin(pi*(dk^2 - ra^2)/(rd^2 - ra^2))/(rd^2 - ra^2);
    elseif dk > ro
        sk = L2 + L3 * cos(pi*(dk^2 - ro^2)/(ra^2 - ro^2));
        dsk = -2*pi*dk*ddk*sin(pi*(dk^2 - ro^2)/(ra^2 - ro^2))/(ra^2 - ro^2);
    else
        sk = 1;
        dsk = [0;0];
    end
    ds = ds + dsk; s = s + sk;
    dbeta = dbeta + dbetak;
    beta = beta + betak;
end

mu = 0.01;
Kb = 5;
% Kb = 20;
% y = Kb * (dsk *(betak + mu) - dbetak * sk)/(betak + mu)^2; 
y = Kb * (ds *(beta + mu) - dbeta * s)/(beta + mu)^2; 


P_wp1=[10;30];  % target location

rrr=[ro;ra;rd];
Cache1=[rrr;P_wp1;zk_(1,:)';zk_(2,:)']; % input for plot111.m
