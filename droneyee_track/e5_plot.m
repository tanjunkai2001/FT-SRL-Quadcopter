% After running the simulation,please run this files to get the plot
close all

t = W.time;
path = pwd;
path1 = 'Figure4paper';
time = datestr(now, 'yymmdd-HH_MM');

%% 
figure(1)
cd(path1);
set(gcf,'Units','centimeter','Position',[5 5 20 10]);
subplot(2,1,1)
set(gca,'LooseInset',get(gca,'TightInset'))
plot(t,W.data,"LineWidth",2,"LineStyle","-")
xlim([0,t(end)])

legend('W_{11}','W_{12}','W_{13}','Fontname','times new Roman','fontsize',16)
xlabel('time(s)','Fontname','times new Roman','fontsize',16)
ylabel('W_1','Fontname','times new Roman','fontsize',16)
grid on
axis normal;

subplot(2,1,2)
set(gca,'LooseInset',get(gca,'TightInset'))
plot(t,W2.data,"LineWidth",2,"LineStyle","-")
xlim([0,t(end)])

legend('W_{21}','W_{21}','W_{23}','Fontname','times new Roman','fontsize',16)
xlabel('time(s)','Fontname','times new Roman','fontsize',16)
ylabel('W_2','Fontname','times new Roman','fontsize',16)
grid on
axis normal;
saveas(1,['weight_',time,'.fig'])
saveas(1,['weight_',time,'.svg'])
cd(path);

%% 
figure(2)
cd(path1);
set(gca,'LooseInset',get(gca,'TightInset'))
subplot(2,1,1)
plot(t,u.data,"LineWidth",2,"LineStyle","-")
xlim([0,t(end)])
ylim([-1.2,1.2])

legend('u_X','u_Y','Fontname','times new Roman','fontsize',16)
xlabel('time(s)','Fontname','times new Roman','fontsize',16)
ylabel('u_i','Fontname','times new Roman','fontsize',16)
grid on
axis normal;

subplot(2,1,2)
plot(t,u2.data,"LineWidth",2,"LineStyle","-")
xlim([0,t(end)])
ylim([-1.2,1.2])

legend('u_X','u_Y','Fontname','times new Roman','fontsize',16)
xlabel('time(s)','Fontname','times new Roman','fontsize',16)
ylabel('u_i','Fontname','times new Roman','fontsize',16)
title('Control input','Fontname','times new Roman','fontsize',16)
grid on
axis normal;

saveas(2,['ctrl_',time,'.fig'])
saveas(2,['ctrl_',time,'.svg'])
cd(path);

%% 
figure(3)
cd(path1);
set(gca,'LooseInset',get(gca,'TightInset'))
plot(t,droneyee3_states_d(:,1),"LineWidth",3,"LineStyle","-")
hold on
plot(t,droneyee3_states(:,1),"LineWidth",3,"LineStyle","-")
legend('p_{d,X}','p_{X}','Fontname','times new Roman','fontsize',16)
xlabel('time(s)','Fontname','times new Roman','fontsize',16)
ylabel('X-axis','Fontname','times new Roman','fontsize',16)
title('State x_1','Fontname','times new Roman','fontsize',16)
grid on
axis normal;
saveas(3,['x1_',time,'.fig'])
saveas(3,['x1_',time,'.svg'])
cd(path);

%% 
figure(4)
cd(path1);
set(gca,'LooseInset',get(gca,'TightInset'))
plot(t,droneyee3_states_d(:,2),"LineWidth",3,"LineStyle","-")
hold on
plot(t,droneyee3_states(:,2),"LineWidth",3,"LineStyle","-")
legend('p_{d,Y}','p_{Y}','Fontname','times new Roman','fontsize',16)
xlabel('time(s)','Fontname','times new Roman','fontsize',16)
ylabel('Y-axis','Fontname','times new Roman','fontsize',16)
title('State x_2','Fontname','times new Roman','fontsize',16)
grid on
axis normal;
saveas(4,['x2_',time,'.fig'])
saveas(4,['x2_',time,'.svg'])
cd(path);

%% 
figure(5)
cd(path1);
set(gca,'LooseInset',get(gca,'TightInset'))
plot(droneyee3_states_d(:,1),droneyee3_states_d(:,2),"LineWidth",3,"LineStyle","-")
hold on
plot(droneyee3_states(:,1),droneyee3_states(:,2),"LineWidth",3,"LineStyle","-")

P_wp1=[0;0];  % target location

x1=Cache1(end,6)+P_wp1(1);y1=Cache1(end,7)+P_wp1(2); % the position of obstacle
x2=Cache1(end,8)+P_wp1(1);y2=Cache1(end,9)+P_wp1(2); % the position of obstacle

ro=Cache1(end,1); % the radius of obstacle
ra=Cache1(end,2); % the radius of obstacle
rd=Cache1(end,3); % Detection radius
theta=0:2*pi/3600:2*pi;
Circle11=x1+ro*cos(theta);
Circle12=y1+ro*sin(theta);
Circle13=x1+ra*cos(theta);
Circle14=y1+ra*sin(theta);
Circle15=x1+rd*cos(theta);
Circle16=y1+rd*sin(theta);
Circle21=x2+ro*cos(theta);
Circle22=y2+ro*sin(theta);
Circle23=x2+ra*cos(theta);
Circle24=y2+ra*sin(theta);
Circle25=x2+rd*cos(theta);
Circle26=y2+rd*sin(theta);
axis equal
grid on

hold on
fill(Circle11,Circle12,'y') % plot obstacle
plot(Circle13,Circle14,'m','Linewidth',1); % plot cicle whose radius is r0~
plot(Circle15,Circle16,'-','Linewidth',1); % plot cicle whose radius is r0~

% hold on
% fill(Circle21,Circle22,'y') % plot obstacle
% plot(Circle23,Circle24,'m','Linewidth',1); % plot cicle whose radius is r0~
% plot(Circle25,Circle26,'-','Linewidth',1); % plot cicle whose radius is r0~
% xlabel('x(m)')
% ylabel('y(m)')
% title('Quadrotor trajectory')
% legend('Desired trj','Actual trj','Start point','End point','Location','best')
% 
legend('p_{X}','p_{Y}','Fontname','times new Roman','fontsize',16)
xlabel('X-axis','Fontname','times new Roman','fontsize',16)
ylabel('Y-axis','Fontname','times new Roman','fontsize',16)
title('Trajectory of Quadrotor','Fontname','times new Roman','fontsize',16)


grid on
axis equal;
saveas(5,['x_',time,'.fig'])
saveas(5,['x_',time,'.svg'])
cd(path);

%% 
figure(6)
cd(path1);
set(gcf,'Units','centimeter','Position',[5 5 20 10]);
subplot(2,1,1)
set(gca,'LooseInset',get(gca,'TightInset'))
plot(t,droneyee3_states_d(:,1)-droneyee3_states(:,1),"LineWidth",2,"LineStyle","-","Color",'b')
xlim([0,t(end)])
ylim([-1.5,1.5])
legend('e_X','Fontname','times new Roman','Location','Southeast','fontsize',12)
xlabel('time(s)','Fontname','times new Roman','fontsize',14)
ylabel('Error of X-axis','Fontname','times new Roman','fontsize',14)
% title('X-axis tracking error','Fontname','times new Roman','fontsize',16)
grid on
axis normal;

subplot(2,1,2)
plot(t,droneyee3_states_d(:,2)-droneyee3_states(:,2),"LineWidth",2,"LineStyle","-","Color",'b')
xlim([0,t(end)])
ylim([-2.5,1.5])
legend('e_Y','Fontname','times new Roman','Location','Southeast','fontsize',12)
xlabel('time(s)','Fontname','times new Roman','fontsize',14)
ylabel('Error of Y-axis','Fontname','times new Roman','fontsize',14)
% title('Y-axis tracking error','Fontname','times new Roman','fontsize',16)
grid on
axis normal;
% tightfig;
saveas(6,['dx_',time,'.fig'])
saveas(6,['dx_',time,'.svg'])
cd(path);

%% 
figure(7)
cd(path1);
set(gcf,'Units','centimeter','Position',[5 5 20 10]);
subplot(2,1,1)
set(gca,'LooseInset',get(gca,'TightInset'))
alpha = 0.25;
plot(t,droneyee3_states_d(:,1),"LineWidth",2,"LineStyle","-",'Color', [1, 0.5, 0])
hold on
% plot(t,droneyee3_states(:,1),"LineWidth",2.5,"LineStyle","-",'Color', [0.5 0.5 0.5])
% plot(t,droneyee3_states(:,1),"LineWidth",2,"LineStyle","-",'Color', [0 0 0])
plot(t,droneyee3_states(:,1),"LineWidth",2,"LineStyle","-",'Color', [alpha alpha alpha])
xlim([0,t(end)])
ylim([-2,3.2])
legend('p_{d,X}','p_X','Fontname','times new Roman','Location','northeast','fontsize',12,'Orientation','Horizontal')
xlabel('time(s)','Fontname','times new Roman','fontsize',14)
ylabel('Position of X-axis','Fontname','times new Roman','fontsize',14)
% title('X-axis tracking error','Fontname','times new Roman','fontsize',16)
grid on
axis normal;

subplot(2,1,2)
plot(t,droneyee3_states_d(:,2),"LineWidth",2,"LineStyle","-",'Color', [1, 0.5, 0])
hold on
% plot(t,droneyee3_states(:,2),"LineWidth",2.5,"LineStyle","-",'Color', [0.5 0.5 0.5])
% plot(t,droneyee3_states(:,2),"LineWidth",2,"LineStyle","-",'Color', [0 0 0])
plot(t,droneyee3_states(:,2),"LineWidth",2,"LineStyle","-",'Color', [alpha alpha alpha])
xlim([0,t(end)])
ylim([-2,3.2])
legend('p_{d,Y}','p_Y','Fontname','times new Roman','Location','northeast','fontsize',12,'Orientation','Horizontal')
xlabel('time(s)','Fontname','times new Roman','fontsize',14)
ylabel('Position of Y-axis','Fontname','times new Roman','fontsize',14)
% title('Y-axis tracking error','Fontname','times new Roman','fontsize',16)
grid on
axis normal;
% tightfig;
saveas(7,['x12_',time,'.fig'])
saveas(7,['x12_',time,'.svg'])
cd(path);

%% 
figure(8)
cd(path1);
set(gca,'LooseInset',get(gca,'TightInset'))
len = length(droneyee3_states_d(:,3));

% plot3(droneyee3_states_d(:,1),droneyee3_states_d(:,2),(-droneyee3_states_d(:,3)+1)/2,"LineWidth",2,"LineStyle","-",'Color', [1, 0.5, 0])
plot3(droneyee3_states_d(251:end-250,1),droneyee3_states_d(251:end-250,2),ones(len-500,1),"LineWidth",2,"LineStyle","-",'Color', [1, 0.5, 0])
hold on
plot3(droneyee3_states(:,1),droneyee3_states(:,2),-droneyee3_states(:,3),"LineWidth",1,"LineStyle","-",'Color', [0.5 0.5 0.5])
hold on

plot3(droneyee3_states(1,1),droneyee3_states(1,2),-droneyee3_states(1,3),"o",'MarkerFaceColor','blue',"LineWidth",0.1, 'MarkerSize', 7) % 'Take-off point'
hold on
plot3(droneyee3_states(end,1),droneyee3_states(end,2),-droneyee3_states(end,3),"o",'MarkerFaceColor','red',"LineWidth",0.1, 'MarkerSize', 7) % 'Land point'
hold on

delta = 1/30;
t1 = 28/delta;
t2 = 44.4/delta;
t3 = 62.8/delta;
t4 = 75.7/delta;
plot3(droneyee3_states(t1,1),droneyee3_states(t1,2),-droneyee3_states(t1,3),"o",'MarkerFaceColor','green',"LineWidth",0.1, 'MarkerSize', 7) % 'Land point'
hold on
plot3(droneyee3_states(t2,1),droneyee3_states(t2,2),-droneyee3_states(t2,3),"o",'MarkerFaceColor','yellow',"LineWidth",0.1, 'MarkerSize', 7) % 'Land point'
hold on
plot3(droneyee3_states(t3,1),droneyee3_states(t3,2),-droneyee3_states(t3,3),"o",'MarkerFaceColor','cyan',"LineWidth",0.1, 'MarkerSize', 7) % 'Land point'
hold on
plot3(droneyee3_states(t4,1),droneyee3_states(t4,2),-droneyee3_states(t4,3),"o",'MarkerFaceColor','magenta',"LineWidth",0.1, 'MarkerSize', 7) % 'Land point'
hold on
zlim([0,1.2])
legend('DMP-based trajactory','Quadrotor trajactory','Take-off point','Land point','28.0s','44.4s','62.8s','75.7s','Fontname','times new Roman','fontsize',12,'Orientation','vertical','location','North','NumColumns', 4)
% legend('Take-off point','Land point','28.0s','44.4s','62.8s','75.7s','DMP-based trajactory','Quadrotor trajactory','Fontname','times new Roman','fontsize',12,'Orientation','horizontal','location','North','NumColumns', 3)
xlabel('X-axis','Fontname','times new Roman','fontsize',16)
ylabel('Y-axis','Fontname','times new Roman','fontsize',16)
% title('Trajectory of Quadrotor','Fontname','times new Roman','fontsize',16)
grid on
axis normal;
saveas(8,['x123_',time,'.fig'])
saveas(8,['x123_',time,'.svg'])
cd(path);

