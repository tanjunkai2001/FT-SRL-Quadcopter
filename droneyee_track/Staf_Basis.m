function [ sig , sig_p ] = Staf_Basis(x)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

s=0.7;
dbar=0.00001;
v2 = 1;
normalize = 0;

d1=s*[0;1];
d2=s*[0.8660;-0.5];
d3=s*[-0.8660;-0.5];

nm=(x.'*x+dbar)/(1+v2*(x.'*x));

d11 = d1(1); 
d12 = d1(2);
d21 = d2(1);
d22 = d2(2);
d31 = d3(1);
d32 = d3(2);
D=[d1 d2 d3];
x1 = x(1);
x2 = x(2);
 L=size(D,2);
    n=length(x);
    sig = zeros(L,1);
    sig_p = zeros(L,n);
if normalize == 0
    for i=1:size(D,2)
        sig(i,1)=exp(x.'*(x+nm.*D(:,i)))-1;
        sig_p(i,:)=(2*x+nm.*D(:,i)+2*(1-v2*dbar)*x*D(:,i)'*x/(1+v2*(x.'*x))^2)'*exp(x'*(x+nm.*D(:,i)));
    end
else
    sig=[(exp(x.'*(x+nm.*d1))-1)/sqrt(exp((x+nm.*d1).'*(x+nm.*d1)));...
        (exp(x.'*(x+nm.*d2))-1)/sqrt(exp((x+nm.*d2).'*(x+nm.*d2)));...
        (exp(x.'*(x+nm.*d3))-1)/sqrt(exp((x+nm.*d3).'*(x+nm.*d3)))];
    sig_p = [[(exp(x1*(x1 + (d11*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d12*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))*(x1 + x1*((2*d11*x1)/(v2*(x1^2 + x2^2) + 1) - (2*d11*v2*x1*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2 + 1) + x2*((2*d12*x1)/(v2*(x1^2 + x2^2) + 1) - (2*d12*v2*x1*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2) + (d11*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))/exp((x1 + (d11*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2 + (x2 + (d12*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2)^(1/2) - (exp(x1*(x1 + (d11*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d12*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))*exp((x1 + (d11*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2 + (x2 + (d12*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2)*(2*(x1 + (d11*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))*((2*d11*x1)/(v2*(x1^2 + x2^2) + 1) - (2*d11*v2*x1*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2 + 1) + 2*((2*d12*x1)/(v2*(x1^2 + x2^2) + 1) - (2*d12*v2*x1*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2)*(x2 + (d12*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))))/(2*exp((x1 + (d11*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2 + (x2 + (d12*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2)^(3/2))...
        (exp(x1*(x1 + (d11*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d12*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))*(x2 + x1*((2*d11*x2)/(v2*(x1^2 + x2^2) + 1) - (2*d11*v2*x2*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2) + x2*((2*d12*x2)/(v2*(x1^2 + x2^2) + 1) - (2*d12*v2*x2*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2 + 1) + (d12*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))/exp((x1 + (d11*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2 + (x2 + (d12*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2)^(1/2) - (exp(x1*(x1 + (d11*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d12*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))*exp((x1 + (d11*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2 + (x2 + (d12*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2)*(2*((2*d11*x2)/(v2*(x1^2 + x2^2) + 1) - (2*d11*v2*x2*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2)*(x1 + (d11*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + 2*(x2 + (d12*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))*((2*d12*x2)/(v2*(x1^2 + x2^2) + 1) - (2*d12*v2*x2*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2 + 1)))/(2*exp((x1 + (d11*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2 + (x2 + (d12*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2)^(3/2))];...
        [(exp(x1*(x1 + (d21*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d22*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))*(x1 + x1*((2*d21*x1)/(v2*(x1^2 + x2^2) + 1) - (2*d21*v2*x1*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2 + 1) + x2*((2*d22*x1)/(v2*(x1^2 + x2^2) + 1) - (2*d22*v2*x1*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2) + (d21*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))/exp((x1 + (d21*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2 + (x2 + (d22*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2)^(1/2) - (exp(x1*(x1 + (d21*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d22*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))*exp((x1 + (d21*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2 + (x2 + (d22*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2)*(2*(x1 + (d21*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))*((2*d21*x1)/(v2*(x1^2 + x2^2) + 1) - (2*d21*v2*x1*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2 + 1) + 2*((2*d22*x1)/(v2*(x1^2 + x2^2) + 1) - (2*d22*v2*x1*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2)*(x2 + (d22*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))))/(2*exp((x1 + (d21*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2 + (x2 + (d22*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2)^(3/2))...
        (exp(x1*(x1 + (d21*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d22*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))*(x2 + x1*((2*d21*x2)/(v2*(x1^2 + x2^2) + 1) - (2*d21*v2*x2*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2) + x2*((2*d22*x2)/(v2*(x1^2 + x2^2) + 1) - (2*d22*v2*x2*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2 + 1) + (d22*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))/exp((x1 + (d21*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2 + (x2 + (d22*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2)^(1/2) - (exp(x1*(x1 + (d21*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d22*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))*exp((x1 + (d21*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2 + (x2 + (d22*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2)*(2*((2*d21*x2)/(v2*(x1^2 + x2^2) + 1) - (2*d21*v2*x2*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2)*(x1 + (d21*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + 2*(x2 + (d22*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))*((2*d22*x2)/(v2*(x1^2 + x2^2) + 1) - (2*d22*v2*x2*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2 + 1)))/(2*exp((x1 + (d21*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2 + (x2 + (d22*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2)^(3/2))];...
        [(exp(x1*(x1 + (d31*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d32*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))*(x1 + x1*((2*d31*x1)/(v2*(x1^2 + x2^2) + 1) - (2*d31*v2*x1*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2 + 1) + x2*((2*d32*x1)/(v2*(x1^2 + x2^2) + 1) - (2*d32*v2*x1*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2) + (d31*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))/exp((x1 + (d31*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2 + (x2 + (d32*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2)^(1/2) - (exp(x1*(x1 + (d31*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d32*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))*exp((x1 + (d31*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2 + (x2 + (d32*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2)*(2*(x1 + (d31*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))*((2*d31*x1)/(v2*(x1^2 + x2^2) + 1) - (2*d31*v2*x1*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2 + 1) + 2*((2*d32*x1)/(v2*(x1^2 + x2^2) + 1) - (2*d32*v2*x1*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2)*(x2 + (d32*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))))/(2*exp((x1 + (d31*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2 + (x2 + (d32*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2)^(3/2))...
        (exp(x1*(x1 + (d31*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d32*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))*(x2 + x1*((2*d31*x2)/(v2*(x1^2 + x2^2) + 1) - (2*d31*v2*x2*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2) + x2*((2*d32*x2)/(v2*(x1^2 + x2^2) + 1) - (2*d32*v2*x2*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2 + 1) + (d32*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))/exp((x1 + (d31*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2 + (x2 + (d32*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2)^(1/2) - (exp(x1*(x1 + (d31*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d32*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))*exp((x1 + (d31*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2 + (x2 + (d32*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2)*(2*((2*d31*x2)/(v2*(x1^2 + x2^2) + 1) - (2*d31*v2*x2*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2)*(x1 + (d31*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + 2*(x2 + (d32*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))*((2*d32*x2)/(v2*(x1^2 + x2^2) + 1) - (2*d32*v2*x2*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2 + 1)))/(2*exp((x1 + (d31*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2 + (x2 + (d32*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))^2)^(3/2))]];
end    

%     sig_p=[(2*x+nm.*d1+2*(1-dbar)*x*d1'*x/(1+x.'*x)^2)'*exp(x'*(x+nm.*d1));
%            (2*x+nm.*d2+2*(1-dbar)*x*d2'*x/(1+x.'*x)^2)'*exp(x'*(x+nm.*d2));
%            (2*x+nm.*d3+2*(1-dbar)*x*d3'*x/(1+x.'*x)^2)'*exp(x'*(x+nm.*d3))];
%     sig=[exp(x.'*(x+nm.*d1))/sqrt(exp((x).'*(x)))-1;...
%         exp(x.'*(x+nm.*d2))/sqrt(exp((x).'*(x)))-1;...
%         exp(x.'*(x+nm.*d3))/sqrt(exp((x).'*(x)))-1];
%     sig_p = [[(exp(x1*(x1 + (d11*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d12*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))*(x1 + x1*((2*d11*x1)/(v2*(x1^2 + x2^2) + 1) - (2*d11*v2*x1*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2 + 1) + x2*((2*d12*x1)/(v2*(x1^2 + x2^2) + 1) - (2*d12*v2*x1*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2) + (d11*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))/exp(x1^2 + x2^2)^(1/2) - (x1*exp(x1^2 + x2^2)*exp(x1*(x1 + (d11*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d12*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))))/exp(x1^2 + x2^2)^(3/2)...
%         (exp(x1*(x1 + (d11*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d12*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))*(x2 + x1*((2*d11*x2)/(v2*(x1^2 + x2^2) + 1) - (2*d11*v2*x2*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2) + x2*((2*d12*x2)/(v2*(x1^2 + x2^2) + 1) - (2*d12*v2*x2*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2 + 1) + (d12*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))/exp(x1^2 + x2^2)^(1/2) - (x2*exp(x1^2 + x2^2)*exp(x1*(x1 + (d11*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d12*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))))/exp(x1^2 + x2^2)^(3/2)];...
%         [(exp(x1*(x1 + (d21*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d22*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))*(x1 + x1*((2*d21*x1)/(v2*(x1^2 + x2^2) + 1) - (2*d21*v2*x1*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2 + 1) + x2*((2*d22*x1)/(v2*(x1^2 + x2^2) + 1) - (2*d22*v2*x1*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2) + (d21*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))/exp(x1^2 + x2^2)^(1/2) - (x1*exp(x1^2 + x2^2)*exp(x1*(x1 + (d21*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d22*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))))/exp(x1^2 + x2^2)^(3/2)...
%         (exp(x1*(x1 + (d21*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d22*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))*(x2 + x1*((2*d21*x2)/(v2*(x1^2 + x2^2) + 1) - (2*d21*v2*x2*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2) + x2*((2*d22*x2)/(v2*(x1^2 + x2^2) + 1) - (2*d22*v2*x2*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2 + 1) + (d22*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))/exp(x1^2 + x2^2)^(1/2) - (x2*exp(x1^2 + x2^2)*exp(x1*(x1 + (d21*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d22*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))))/exp(x1^2 + x2^2)^(3/2)];...
%         [(exp(x1*(x1 + (d31*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d32*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))*(x1 + x1*((2*d31*x1)/(v2*(x1^2 + x2^2) + 1) - (2*d31*v2*x1*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2 + 1) + x2*((2*d32*x1)/(v2*(x1^2 + x2^2) + 1) - (2*d32*v2*x1*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2) + (d31*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))/exp(x1^2 + x2^2)^(1/2) - (x1*exp(x1^2 + x2^2)*exp(x1*(x1 + (d31*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d32*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))))/exp(x1^2 + x2^2)^(3/2)...
%         (exp(x1*(x1 + (d31*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d32*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))*(x2 + x1*((2*d31*x2)/(v2*(x1^2 + x2^2) + 1) - (2*d31*v2*x2*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2) + x2*((2*d32*x2)/(v2*(x1^2 + x2^2) + 1) - (2*d32*v2*x2*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)^2 + 1) + (d32*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)))/exp(x1^2 + x2^2)^(1/2) - (x2*exp(x1^2 + x2^2)*exp(x1*(x1 + (d31*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1)) + x2*(x2 + (d32*(x1^2 + x2^2 + dbar))/(v2*(x1^2 + x2^2) + 1))))/exp(x1^2 + x2^2)^(3/2)]];
    
%     sig=[exp(x.'*(x+nm.*d1))/(exp((x).'*(x)))-1;...
%         exp(x.'*(x+nm.*d2))/(exp((x).'*(x)))-1;...
%         exp(x.'*(x+nm.*d3))/(exp((x).'*(x)))-1];
%     sig_p = [[(exp(((d11*x1 + d12*x2)*(x1^2 + x2^2 + dbar))/(v2*x1^2 + v2*x2^2 + 1))*(d11*dbar + 3*d11*x1^2 + d11*x2^2 + d11*v2*x1^4 + d11*v2*x2^4 + 2*d12*x1*x2 - d11*dbar*v2*x1^2 + d11*dbar*v2*x2^2 + 2*d11*v2*x1^2*x2^2 - 2*d12*dbar*v2*x1*x2))/(v2*x1^2 + v2*x2^2 + 1)^2 ...
%         (exp(((d11*x1 + d12*x2)*(x1^2 + x2^2 + dbar))/(v2*x1^2 + v2*x2^2 + 1))*(d12*dbar + d12*x1^2 + 3*d12*x2^2 + d12*v2*x1^4 + d12*v2*x2^4 + 2*d11*x1*x2 + d12*dbar*v2*x1^2 - d12*dbar*v2*x2^2 + 2*d12*v2*x1^2*x2^2 - 2*d11*dbar*v2*x1*x2))/(v2*x1^2 + v2*x2^2 + 1)^2];...
%         [(exp(((d21*x1 + d22*x2)*(x1^2 + x2^2 + dbar))/(v2*x1^2 + v2*x2^2 + 1))*(d21*dbar + 3*d21*x1^2 + d21*x2^2 + d21*v2*x1^4 + d21*v2*x2^4 + 2*d22*x1*x2 - d21*dbar*v2*x1^2 + d21*dbar*v2*x2^2 + 2*d21*v2*x1^2*x2^2 - 2*d22*dbar*v2*x1*x2))/(v2*x1^2 + v2*x2^2 + 1)^2 ...
%         (exp(((d21*x1 + d22*x2)*(x1^2 + x2^2 + dbar))/(v2*x1^2 + v2*x2^2 + 1))*(d22*dbar + d22*x1^2 + 3*d22*x2^2 + d22*v2*x1^4 + d22*v2*x2^4 + 2*d21*x1*x2 + d22*dbar*v2*x1^2 - d22*dbar*v2*x2^2 + 2*d22*v2*x1^2*x2^2 - 2*d21*dbar*v2*x1*x2))/(v2*x1^2 + v2*x2^2 + 1)^2];...
%         [(exp(((d31*x1 + d32*x2)*(x1^2 + x2^2 + dbar))/(v2*x1^2 + v2*x2^2 + 1))*(d31*dbar + 3*d31*x1^2 + d31*x2^2 + d31*v2*x1^4 + d31*v2*x2^4 + 2*d32*x1*x2 - d31*dbar*v2*x1^2 + d31*dbar*v2*x2^2 + 2*d31*v2*x1^2*x2^2 - 2*d32*dbar*v2*x1*x2))/(v2*x1^2 + v2*x2^2 + 1)^2 ...
%         (exp(((d31*x1 + d32*x2)*(x1^2 + x2^2 + dbar))/(v2*x1^2 + v2*x2^2 + 1))*(d32*dbar + d32*x1^2 + 3*d32*x2^2 + d32*v2*x1^4 + d32*v2*x2^4 + 2*d31*x1*x2 + d32*dbar*v2*x1^2 - d32*dbar*v2*x2^2 + 2*d32*v2*x1^2*x2^2 - 2*d31*dbar*v2*x1*x2))/(v2*x1^2 + v2*x2^2 + 1)^2]];
%     
%     sig=[exp(x.'*(x+nm.*d1))/(exp((x+nm.*d1).'*(x+nm.*d1)))-1;...
%         exp(x.'*(x+nm.*d2))/(exp((x+nm.*d2).'*(x+nm.*d2)))-1;...
%         exp(x.'*(x+nm.*d3))/(exp((x+nm.*d3).'*(x+nm.*d3)))-1];
%     sig_p = [[-(exp(-((x1^2 + x2^2 + dbar)*(d11^2*x1^2 + d11^2*x2^2 + dbar*d11^2 + v2*d11*x1^3 + v2*d11*x1*x2^2 + d11*x1 + d12^2*x1^2 + d12^2*x2^2 + dbar*d12^2 + v2*d12*x1^2*x2 + v2*d12*x2^3 + d12*x2))/(v2*x1^2 + v2*x2^2 + 1)^2)*(- 4*d11^2*dbar^2*v2*x1 - 4*d11^2*dbar*v2*x1^3 - 4*d11^2*dbar*v2*x1*x2^2 + 4*d11^2*dbar*x1 + 4*d11^2*x1^3 + 4*d11^2*x1*x2^2 - d11*dbar*v2^2*x1^4 + d11*dbar*v2^2*x2^4 + 2*d11*dbar*v2*x2^2 + d11*dbar + d11*v2^2*x1^6 + 3*d11*v2^2*x1^4*x2^2 + 3*d11*v2^2*x1^2*x2^4 + d11*v2^2*x2^6 + 4*d11*v2*x1^4 + 6*d11*v2*x1^2*x2^2 + 2*d11*v2*x2^4 + 3*d11*x1^2 + d11*x2^2 - 4*d12^2*dbar^2*v2*x1 - 4*d12^2*dbar*v2*x1^3 - 4*d12^2*dbar*v2*x1*x2^2 + 4*d12^2*dbar*x1 + 4*d12^2*x1^3 + 4*d12^2*x1*x2^2 - 2*d12*dbar*v2^2*x1^3*x2 - 2*d12*dbar*v2^2*x1*x2^3 - 2*d12*dbar*v2*x1*x2 + 2*d12*v2*x1^3*x2 + 2*d12*v2*x1*x2^3 + 2*d12*x1*x2))/(v2*x1^2 + v2*x2^2 + 1)^3 ...
%         -(exp(-((x1^2 + x2^2 + dbar)*(d11^2*x1^2 + d11^2*x2^2 + dbar*d11^2 + v2*d11*x1^3 + v2*d11*x1*x2^2 + d11*x1 + d12^2*x1^2 + d12^2*x2^2 + dbar*d12^2 + v2*d12*x1^2*x2 + v2*d12*x2^3 + d12*x2))/(v2*x1^2 + v2*x2^2 + 1)^2)*(- 4*d11^2*dbar^2*v2*x2 - 4*d11^2*dbar*v2*x1^2*x2 - 4*d11^2*dbar*v2*x2^3 + 4*d11^2*dbar*x2 + 4*d11^2*x1^2*x2 + 4*d11^2*x2^3 - 2*d11*dbar*v2^2*x1^3*x2 - 2*d11*dbar*v2^2*x1*x2^3 - 2*d11*dbar*v2*x1*x2 + 2*d11*v2*x1^3*x2 + 2*d11*v2*x1*x2^3 + 2*d11*x1*x2 - 4*d12^2*dbar^2*v2*x2 - 4*d12^2*dbar*v2*x1^2*x2 - 4*d12^2*dbar*v2*x2^3 + 4*d12^2*dbar*x2 + 4*d12^2*x1^2*x2 + 4*d12^2*x2^3 + d12*dbar*v2^2*x1^4 - d12*dbar*v2^2*x2^4 + 2*d12*dbar*v2*x1^2 + d12*dbar + d12*v2^2*x1^6 + 3*d12*v2^2*x1^4*x2^2 + 3*d12*v2^2*x1^2*x2^4 + d12*v2^2*x2^6 + 2*d12*v2*x1^4 + 6*d12*v2*x1^2*x2^2 + 4*d12*v2*x2^4 + d12*x1^2 + 3*d12*x2^2))/(v2*x1^2 + v2*x2^2 + 1)^3];...
%         [-(exp(-((x1^2 + x2^2 + dbar)*(d21^2*x1^2 + d21^2*x2^2 + dbar*d21^2 + v2*d21*x1^3 + v2*d21*x1*x2^2 + d21*x1 + d22^2*x1^2 + d22^2*x2^2 + dbar*d22^2 + v2*d22*x1^2*x2 + v2*d22*x2^3 + d22*x2))/(v2*x1^2 + v2*x2^2 + 1)^2)*(- 4*d21^2*dbar^2*v2*x1 - 4*d21^2*dbar*v2*x1^3 - 4*d21^2*dbar*v2*x1*x2^2 + 4*d21^2*dbar*x1 + 4*d21^2*x1^3 + 4*d21^2*x1*x2^2 - d21*dbar*v2^2*x1^4 + d21*dbar*v2^2*x2^4 + 2*d21*dbar*v2*x2^2 + d21*dbar + d21*v2^2*x1^6 + 3*d21*v2^2*x1^4*x2^2 + 3*d21*v2^2*x1^2*x2^4 + d21*v2^2*x2^6 + 4*d21*v2*x1^4 + 6*d21*v2*x1^2*x2^2 + 2*d21*v2*x2^4 + 3*d21*x1^2 + d21*x2^2 - 4*d22^2*dbar^2*v2*x1 - 4*d22^2*dbar*v2*x1^3 - 4*d22^2*dbar*v2*x1*x2^2 + 4*d22^2*dbar*x1 + 4*d22^2*x1^3 + 4*d22^2*x1*x2^2 - 2*d22*dbar*v2^2*x1^3*x2 - 2*d22*dbar*v2^2*x1*x2^3 - 2*d22*dbar*v2*x1*x2 + 2*d22*v2*x1^3*x2 + 2*d22*v2*x1*x2^3 + 2*d22*x1*x2))/(v2*x1^2 + v2*x2^2 + 1)^3 ...
%         -(exp(-((x1^2 + x2^2 + dbar)*(d21^2*x1^2 + d21^2*x2^2 + dbar*d21^2 + v2*d21*x1^3 + v2*d21*x1*x2^2 + d21*x1 + d22^2*x1^2 + d22^2*x2^2 + dbar*d22^2 + v2*d22*x1^2*x2 + v2*d22*x2^3 + d22*x2))/(v2*x1^2 + v2*x2^2 + 1)^2)*(- 4*d21^2*dbar^2*v2*x2 - 4*d21^2*dbar*v2*x1^2*x2 - 4*d21^2*dbar*v2*x2^3 + 4*d21^2*dbar*x2 + 4*d21^2*x1^2*x2 + 4*d21^2*x2^3 - 2*d21*dbar*v2^2*x1^3*x2 - 2*d21*dbar*v2^2*x1*x2^3 - 2*d21*dbar*v2*x1*x2 + 2*d21*v2*x1^3*x2 + 2*d21*v2*x1*x2^3 + 2*d21*x1*x2 - 4*d22^2*dbar^2*v2*x2 - 4*d22^2*dbar*v2*x1^2*x2 - 4*d22^2*dbar*v2*x2^3 + 4*d22^2*dbar*x2 + 4*d22^2*x1^2*x2 + 4*d22^2*x2^3 + d22*dbar*v2^2*x1^4 - d22*dbar*v2^2*x2^4 + 2*d22*dbar*v2*x1^2 + d22*dbar + d22*v2^2*x1^6 + 3*d22*v2^2*x1^4*x2^2 + 3*d22*v2^2*x1^2*x2^4 + d22*v2^2*x2^6 + 2*d22*v2*x1^4 + 6*d22*v2*x1^2*x2^2 + 4*d22*v2*x2^4 + d22*x1^2 + 3*d22*x2^2))/(v2*x1^2 + v2*x2^2 + 1)^3];...
%         [-(exp(-((x1^2 + x2^2 + dbar)*(d31^2*x1^2 + d31^2*x2^2 + dbar*d31^2 + v2*d31*x1^3 + v2*d31*x1*x2^2 + d31*x1 + d32^2*x1^2 + d32^2*x2^2 + dbar*d32^2 + v2*d32*x1^2*x2 + v2*d32*x2^3 + d32*x2))/(v2*x1^2 + v2*x2^2 + 1)^2)*(- 4*d31^2*dbar^2*v2*x1 - 4*d31^2*dbar*v2*x1^3 - 4*d31^2*dbar*v2*x1*x2^2 + 4*d31^2*dbar*x1 + 4*d31^2*x1^3 + 4*d31^2*x1*x2^2 - d31*dbar*v2^2*x1^4 + d31*dbar*v2^2*x2^4 + 2*d31*dbar*v2*x2^2 + d31*dbar + d31*v2^2*x1^6 + 3*d31*v2^2*x1^4*x2^2 + 3*d31*v2^2*x1^2*x2^4 + d31*v2^2*x2^6 + 4*d31*v2*x1^4 + 6*d31*v2*x1^2*x2^2 + 2*d31*v2*x2^4 + 3*d31*x1^2 + d31*x2^2 - 4*d32^2*dbar^2*v2*x1 - 4*d32^2*dbar*v2*x1^3 - 4*d32^2*dbar*v2*x1*x2^2 + 4*d32^2*dbar*x1 + 4*d32^2*x1^3 + 4*d32^2*x1*x2^2 - 2*d32*dbar*v2^2*x1^3*x2 - 2*d32*dbar*v2^2*x1*x2^3 - 2*d32*dbar*v2*x1*x2 + 2*d32*v2*x1^3*x2 + 2*d32*v2*x1*x2^3 + 2*d32*x1*x2))/(v2*x1^2 + v2*x2^2 + 1)^3 ...
%         -(exp(-((x1^2 + x2^2 + dbar)*(d31^2*x1^2 + d31^2*x2^2 + dbar*d31^2 + v2*d31*x1^3 + v2*d31*x1*x2^2 + d31*x1 + d32^2*x1^2 + d32^2*x2^2 + dbar*d32^2 + v2*d32*x1^2*x2 + v2*d32*x2^3 + d32*x2))/(v2*x1^2 + v2*x2^2 + 1)^2)*(- 4*d31^2*dbar^2*v2*x2 - 4*d31^2*dbar*v2*x1^2*x2 - 4*d31^2*dbar*v2*x2^3 + 4*d31^2*dbar*x2 + 4*d31^2*x1^2*x2 + 4*d31^2*x2^3 - 2*d31*dbar*v2^2*x1^3*x2 - 2*d31*dbar*v2^2*x1*x2^3 - 2*d31*dbar*v2*x1*x2 + 2*d31*v2*x1^3*x2 + 2*d31*v2*x1*x2^3 + 2*d31*x1*x2 - 4*d32^2*dbar^2*v2*x2 - 4*d32^2*dbar*v2*x1^2*x2 - 4*d32^2*dbar*v2*x2^3 + 4*d32^2*dbar*x2 + 4*d32^2*x1^2*x2 + 4*d32^2*x2^3 + d32*dbar*v2^2*x1^4 - d32*dbar*v2^2*x2^4 + 2*d32*dbar*v2*x1^2 + d32*dbar + d32*v2^2*x1^6 + 3*d32*v2^2*x1^4*x2^2 + 3*d32*v2^2*x1^2*x2^4 + d32*v2^2*x2^6 + 2*d32*v2*x1^4 + 6*d32*v2*x1^2*x2^2 + 4*d32*v2*x2^4 + d32*x1^2 + 3*d32*x2^2))/(v2*x1^2 + v2*x2^2 + 1)^3]];
    