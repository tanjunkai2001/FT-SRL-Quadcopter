%%%%%%%%%%%%%%%%%%%%%%%%
%  cleaning workspace
% close all/media/droneyee/WININSTALL/Udptest
clear all
clc
clf

%% customize params
uavtype=0055;
fixed_step_size = 1/30;  %step of simulink
UAV_NUM = 1;%%%mistake var name
AUTOLAND = true;  %whether autoland when simulation ends
droneyeeUAV_PLOT = false;
% fignum = 'eight_shaped';
draw_gif = false;
battery_threshold = 20;
% battery_low = 15;
z_d_for_land =1;
erro_wide=0.05;
lmt=0.5;
lmtcar=1;
Fly=1;
Land=0;

XMIN = -2.8; XMAX = 2.8;
YMIN = -2.2; YMAX = 2.2;
ZMIN = 0.7; ZMAX =2.0;
start_high = 0.6;

axis([XMIN*1.2 XMAX*1.2 YMIN*1.2 YMAX*1.2 ZMIN*0.5 ZMAX*1.2]);

xlabel('X(m)');
ylabel('Y(m)');  
zlabel('Z(m)');
box on;
hold on;

%% DMP & ADP & 分层结构参数初始化
l = 3; N = 10;
W0 = 10*ones(l,1); %W0(2,:) = 0;
delta_ = zeros(N,1);
omega_ = zeros(N,l);

% load('DMP_ref.mat')
% load('../../demo_traj_2d/ref_2d_circle_2.mat')
load('../demo_traj_2d/ref_2d_arch.mat')
% load('../../demo_traj_2d/ref_2d_square.mat')
% load('../../demo_traj_2d/ref_2d_twist.mat')

ys = ys_learned - ys_learned(1,:);


%% 
R = 0.7;
omega = 0.3;  %转圈的角速度


w2=30;%%%每秒仿真次数
w1=0.1;%%forth and back frequency
a=1;%2;x aixs R
b=1.8;%2/1.5; Y aixs R
act_end = 2*pi/w1;
k=0.2;
bb=1.2;
tb2=1;%单边活动范围


sim_start_time = 2;  %for system stable
sim_end_time = 300;


%%
%parameters of PID

%%%%%%%%%%飞机%%%%%%%%%%%%%%%%%
KI_x=0.000002;
% KP_x=2.9;
KP_x=1.5;
KD_x=0.000002;


KI_y=0.000002;
% KP_y=2.9;
KP_y=1.5;
KD_y=0.00002;

ki_z=0.002;
kp_z=0.7;
kd_z=0.02;

%%%%%%%%小车%%%%%%%%%%%%%%%%%%%
% KII_x=0.000000;
% KPP_x=0.6;
% KDD_x=0.002;
% 
% 
% KII_y=0.000;
% KPP_y=0.6;
% KDD_y=0.002;

%%%%%%%小车UWB%%%%%%%%%%%%%%%
KII_x=0.000000;
KPP_x=0.4;
KDD_x=0.0008;


KII_y=0.000;
KPP_y=0.4;
KDD_y=0.0008;

% point_time=20;   % 飞机起飞后悬停时间，单位是秒


%%速度�??关，1-打开  0-关闭
Vel_Switch_1=1;
Vel_Switch_2=1;
Vel_Switch_3=1;
Vel_Switch_4=1;
Vel_Switch_5=1;
Vel_Switch_6=1;
Vel_Switch_7=1;
Vel_Switch_8=1;
Vel_Switch_9=1;
Vel_Switch_10=1;
Vel_Switch_11=1;
Vel_Switch_12=1;
Vel_Switch_13=1;
Vel_Switch_14=1;
Vel_Switch_15=1;
Vel_Switch_16=1;
Vel_Switch_17=1;
Vel_Switch_18=1;
Vel_Switch_19=1;
Vel_Switch_20=1;

Vel_Switch_21=1;
Vel_Switch_22=1;
Vel_Switch_23=1;
Vel_Switch_24=1;

car_Switch_1=1;
car_Switch_2=1;
car_Switch_3=1;
car_Switch_4=1;
car_Switch_5=1;
car_Switch_6=1;
car_Switch_7=1;
car_Switch_8=1;
car_Switch_9=1;
car_Switch_10=1;






for i=[1:1:24]
eval(['droneyeeUAV',int2str(i),'_NUM = i;']);
eval(['uav',int2str(i),'num = i;']);

end





% droneyee10uavs_avo
%%open simulator
% droneyee10uav_GPS_2017b