% After running the simulation,please run this files to get the plot
close all
% clear all
% clc
% path = pwd;
path1 = 'Figure4paper';
path2 = 'data_240413';

%% load data
cd(path2)

% 圆轨迹，一个障碍物
load('workspace_241124-14_45.mat') % circle FT-SRL-NZS
% load('workspace_241124-14_55.mat') % circle StaF-SRL-NZS
% load('workspace_241124-15_05.mat') % circle NN-SRL-NZS

% load('workspace_241124-14_38.mat') % circle FT-NZS
% load('workspace_241124-15_19.mat') % circle StaF-NZS
% load('workspace_241124-15_12.mat') % circle NN-NZS


% cd('..\')
cd('../')
path = pwd;
path1 = 'Figure4paper';
path2 = 'data';

savefig_flag = 0;
tightfig_flag = 0;
timefig_flag = 0;

t = W.time;
if timefig_flag == 1
    time = ['_',datestr(now, 'yymmdd-HH_MM')];
else
    time = '';
end

%% setup figure
Figure_size_1 = [500, 500, 500, 250];
Figure_size_2 = [500, 500, 500, 250];

%%
figure('position', Figure_size_1)
start_time = 1;
end_time = length(t);
% 采样间隔
sampling_interval = 1250;
% 获取每隔 sampling_interval 个数据点的索引
indices = start_time:sampling_interval:end_time;
% 调整线宽和标记大小
width = 2;
markersize = 7;
% 定义颜色
color1 = [0.2196    0.5020    0.7490];  % 深蓝色
color2 = [0.8941    0.1020    0.1098];  % 深红色
color3 = [0.4588    0.4392    0.7020];  % 深紫色 

subplot(2, 1, 1)
% 绘制第一条曲线
plot(t(:)-t(start_time), W.data(:,1), 'color', color1, "LineWidth", width, "LineStyle", "-",'Marker','o','MarkerSize',markersize,'MarkerIndices',indices,'MarkerFaceColor', color1)
hold on
% 绘制第二条曲线
plot(t(:)-t(start_time), W.data(:,2), 'color', color2, "LineWidth", width, "LineStyle", "-",'Marker','s','MarkerSize',markersize,'MarkerIndices',indices,'MarkerFaceColor', color2)
hold on
% 绘制第三条曲线
plot(t(:)-t(start_time), W.data(:,3), 'color', color3, "LineWidth", width, "LineStyle", "-",'Marker','d','MarkerSize',markersize,'MarkerIndices',indices,'MarkerFaceColor', color3)

xlim([0, t(end)])

legend('$\hat{W}_1(1)$', '$\hat{W}_1(2)$', '$\hat{W}_1(3)$', 'Fontname', 'times new Roman', 'fontsize', 14, 'Location', 'southeast','interpreter','latex', 'Orientation', 'horizontal','NumColumns',3)
% legend('$W_1$', '$W_2$', '$W_3$', 'Fontname', 'times new Roman', 'fontsize', 14, 'Location', 'southeast','interpreter','latex')
% xlabel('time [s]', 'Fontname', 'times new Roman', 'fontsize', 16)
ylabel('$W_i$', 'Fontname', 'times new Roman', 'fontsize', 16,'Interpreter','latex')
% title('State-following neural network weights', 'Fontname', 'times new Roman', 'fontsize', 16)
grid on
axis normal;

subplot(2, 1, 2)
% 绘制第一条曲线
plot(t(:)-t(start_time), W2.data(:,1), 'color', color1, "LineWidth", width, "LineStyle", "-",'Marker','o','MarkerSize',markersize,'MarkerIndices',indices,'MarkerFaceColor', color1)
hold on
% 绘制第二条曲线
plot(t(:)-t(start_time), W2.data(:,2), 'color', color2, "LineWidth", width, "LineStyle", "-",'Marker','s','MarkerSize',markersize,'MarkerIndices',indices,'MarkerFaceColor', color2)
hold on
% 绘制第三条曲线
plot(t(:)-t(start_time), W2.data(:,3), 'color', color3, "LineWidth", width, "LineStyle", "-",'Marker','d','MarkerSize',markersize,'MarkerIndices',indices,'MarkerFaceColor', color3)

xlim([0, t(end)])

legend('$\hat{W}_2(1)$', '$\hat{W}_2(2)$', '$\hat{W}_2(3)$', 'Fontname', 'times new Roman', 'fontsize', 14, 'Location', 'southeast','interpreter','latex', 'Orientation', 'horizontal','NumColumns',3)

xlabel('time [s]', 'Fontname', 'times new Roman', 'fontsize', 16)
ylabel('$W_i$', 'Fontname', 'times new Roman', 'fontsize', 16,'Interpreter','latex')

grid on
axis normal;

% 获取当前图窗大小
fig = gcf;
fig.Units = 'inches';
figPosition = fig.Position;
width = figPosition(3);
height = figPosition(4);
% 设置保存选项
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 width height]);
set(gcf, 'PaperSize', [width height]);
% 保存为 PDF 文件
path_fig = '../Figures/';
path_now = pwd;
cd(path_fig)

if save_flag == 1
    print(gcf, 'WcH1_exp2.pdf', '-dpdf');
end

cd(path_now);

%%

figure('position', Figure_size_1)
start_time = 1;
end_time = length(t);
colors = [0.4, 0, 0.8; 0.8, 0.2, 0];

subplot(2, 1, 1)
% plot(t, u.data, "LineWidth", 2, "LineStyle", "-")
plot(t(start_time:end_time) - t(start_time), u.data(start_time:end_time, 1), ...
    'LineWidth', 2, 'LineStyle', '-', 'Color', colors(1,:), 'Marker', 'o', ...
    'MarkerIndices', 1:round((end_time-start_time)/10):end_time-start_time, ...
    'MarkerFaceColor', colors(1,:), 'MarkerSize', 6, 'DisplayName', '$u_{X}$')
hold on
plot(t(start_time:end_time) - t(start_time), u.data(start_time:end_time, 2), ...
    'LineWidth', 2, 'LineStyle', '-', 'Color', colors(2,:), 'Marker', 's', ...
    'MarkerIndices', 1:round((end_time-start_time)/10):end_time-start_time, ...
    'MarkerFaceColor', colors(2,:), 'MarkerSize', 6, 'DisplayName', '$u_{Y}$')

xlim([0, t(end)])
ylim([min(min(u.data(start_time:end_time, :))), max(max(u.data(start_time:end_time, :)))]*1.5)

legend('$u_{1,X}$', '$u_{1,Y}$', 'Fontname', 'times new Roman', 'fontsize', 16,'interpreter','latex')
% xlabel('time [s]', 'Fontname', 'times new Roman', 'fontsize', 16)
ylabel('$u_i$', 'Fontname', 'times new Roman', 'fontsize', 16,'Interpreter','latex')
grid on
axis normal;

subplot(2, 1, 2)
plot(t(start_time:end_time) - t(start_time), u2.data(start_time:end_time, 1), ...
    'LineWidth', 2, 'LineStyle', '-', 'Color', colors(1,:), 'Marker', 'o', ...
    'MarkerIndices', 1:round((end_time-start_time)/10):end_time-start_time, ...
    'MarkerFaceColor', colors(1,:), 'MarkerSize', 6, 'DisplayName', '$u_{X}$')
hold on
plot(t(start_time:end_time) - t(start_time), u2.data(start_time:end_time, 2), ...
    'LineWidth', 2, 'LineStyle', '-', 'Color', colors(2,:), 'Marker', 's', ...
    'MarkerIndices', 1:round((end_time-start_time)/10):end_time-start_time, ...
    'MarkerFaceColor', colors(2,:), 'MarkerSize', 6, 'DisplayName', '$u_{Y}$')

xlim([0, t(end)])
ylim([min(min(u2.data(start_time:end_time, :))), max(max(u2.data(start_time:end_time, :)))]*1.5)

legend('$u_{2,X}$', '$u_{2,Y}$', 'Fontname', 'times new Roman', 'fontsize', 16,'interpreter','latex')
xlabel('time [s]', 'Fontname', 'times new Roman', 'fontsize', 16)
ylabel('$u_i$', 'Fontname', 'times new Roman', 'fontsize', 16,'Interpreter','latex')
grid on
axis normal;


if tightfig_flag == 1
    tightfig;
end
if savefig_flag == 1
    saveas(2, ['ctrl_input', time, '.fig'])
    saveas(2, ['ctrl_input', time, '.eps'],'psc')
    saveas(2, ['ctrl_input', time, '.pdf'])
end

cd(path);

%%

figure('position', Figure_size_1)
subplot(2, 1, 1)
plot(t, droneyee3_states_d(:, 1), "LineWidth", 3, "LineStyle", "--", 'Color', [1, 0.5, 0])
hold on
plot(t, droneyee3_states(:, 1), "LineWidth", 3, "LineStyle", "-", 'Color', [0.5 0.5 0.5])

xlim([0, t(end)])

legend('p_{d,X}', 'p_{X}', 'Fontname', 'times new Roman', 'fontsize', 16)
% xlabel('time [s]', 'Fontname', 'times new Roman', 'fontsize', 16)
ylabel('X-axis', 'Fontname', 'times new Roman', 'fontsize', 16)
grid on
axis normal;

subplot(2, 1, 2)
plot(t, droneyee3_states_d(:, 2), "LineWidth", 3, "LineStyle", "--", 'Color', [1, 0.5, 0])
hold on
plot(t, droneyee3_states(:, 2), "LineWidth", 3, "LineStyle", "-", 'Color', [0.5 0.5 0.5])

xlim([0, t(end)])

legend('p_{d,Y}', 'p_{Y}', 'Fontname', 'times new Roman', 'fontsize', 16)
xlabel('time [s]', 'Fontname', 'times new Roman', 'fontsize', 16)
ylabel('Y-axis', 'Fontname', 'times new Roman', 'fontsize', 16)
grid on
axis normal;

if tightfig_flag == 1
    tightfig;
end
if savefig_flag == 1
    saveas(3, ['x1_x2', time, '.fig'])
    saveas(3, ['x1_x2', time, '.eps'],'psc')
    saveas(3, ['x1_x2', time, '.pdf'])
end

cd(path);

%%

figure('position', Figure_size_1)

P_wp1 = [0; 0]; % target location

x1 = Cache1(end, 6) + P_wp1(1); y1 = Cache1(end, 7) + P_wp1(2); % the position of obstacle
x2 = Cache1(end, 8) + P_wp1(1); y2 = Cache1(end, 9) + P_wp1(2); % the position of obstacle

ro = Cache1(end, 1); % the radius of obstacle
ra = Cache1(end, 2); % the radius of obstacle
rd = Cache1(end, 3); % Detection radius
theta = 0:2 * pi / 3600:2 * pi;
Circle11 = x1 + ro * cos(theta);
Circle12 = y1 + ro * sin(theta);
Circle13 = x1 + ra * cos(theta);
Circle14 = y1 + ra * sin(theta);
Circle15 = x1 + rd * cos(theta);
Circle16 = y1 + rd * sin(theta);
Circle21 = x2 + ro * cos(theta);
Circle22 = y2 + ro * sin(theta);
Circle23 = x2 + ra * cos(theta);
Circle24 = y2 + ra * sin(theta);
Circle25 = x2 + rd * cos(theta);
Circle26 = y2 + rd * sin(theta);

% plot(droneyee3_states_d(:, 1), droneyee3_states_d(:, 2), "LineWidth", 3, "LineStyle", "-")
% plot(droneyee3_states_d(1:3000, 1), droneyee3_states_d(1:3000, 2), "LineWidth", 4, "LineStyle", "--", 'Color', [1, 0.5, 0])
% hold on


% plot(Circle15, Circle16, 'Color', [0.53, 0.81, 0.98], 'Linewidth', 2); % plot cicle whose radius is r0~
% hold on
% fill(Circle15, Circle16, [0.53, 0.81, 0.98], 'FaceAlpha', 0.3, 'LineStyle', '-.','LineWidth', 2, 'EdgeColor', [0.43, 0.71, 0.98]) % plot obstacle
% hold on
% % plot(Circle13, Circle14, 'Color', [1, 0.8, 0.8], 'Linewidth', 2); % plot cicle whose radius is r0~
% % hold on
% fill(Circle13, Circle14, [1, 0.8, 0.8], 'FaceAlpha', 0.8, 'LineStyle', '--', 'LineWidth', 2, 'EdgeColor', [1, 0.6, 0.6]) % plot obstacle
% hold on
% % plot(Circle11, Circle12, 'Color', [0.9, 0.2, 0.2], 'Linewidth', 2); % plot cicle whose radius is r0~
% % hold on
% % fill(Circle11, Circle12, [0.9, 0.2, 0.2], 'LineWidth', 1, 'EdgeColor', [0.9, 0.2, 0.2]) % plot obstacle
% fill(Circle11, Circle12, [1.0, 0.9, 0]/1.0, 'facealpha', 0.8, 'LineStyle', ':', 'LineWidth', 2.5,'EdgeColor', [0.9, 0.6, 0]);
% hold on
% 定义更鲜艳和协调的颜色
color1 = [0.53, 0.81, 0.98]; % 天蓝色
edgeColor1 = [0.33, 0.62, 0.85]; % 较深的天蓝色

color2 = [1, 0.8, 0.8]; % 浅红色
edgeColor2 = [0.85, 0.4, 0.4]; % 较深的红色

% color3 = [1.0, 0.9, 0.0]; % 亮黄色
% color3 = [1.0, 0.9, 0.0]; % 亮黄色
color3 = [1.0, 0.85, 0.1]; % 亮黄色
edgeColor3 = [0.9, 0.6, 0.0]; % 金黄色

% 绘制第一个障碍物
fill(Circle15, Circle16, color1, 'FaceAlpha', 0.4, 'LineStyle', '-.', 'LineWidth', 2, 'EdgeColor', edgeColor1);
hold on;

% 绘制第二个障碍物
fill(Circle13, Circle14, color2, 'FaceAlpha', 0.7, 'LineStyle', '--', 'LineWidth', 2, 'EdgeColor', edgeColor2);
hold on;

% 绘制第三个障碍物
fill(Circle11, Circle12, color3, 'FaceAlpha', 1.0, 'LineStyle', ':', 'LineWidth', 2.5, 'EdgeColor', edgeColor3);
hold on;

% 采样间隔
sampling_interval = 1;
% 获取每隔 sampling_interval 个数据点的索引
indices = 1:sampling_interval:length(droneyee3_states(:, 1));
temp = 2;
% 采样间隔
sampling_interval2 = 60;
% 获取每隔 sampling_interval 个数据点的索引
% indices2 = [start_time:sampling_interval2:end_time,end_time];
indices2 = 1:sampling_interval2:length(droneyee3_states(:, 1));

% 选择平滑窗口大小
window_size = 60;
% 使用移动平均进行平滑处理
smoothed_data = movmean(droneyee3_states, window_size);

% plot(smoothed_data(indices, 1), smoothed_data(indices, 2), "LineWidth", 2, "LineStyle", "-", 'Color', [0.5 0.5 0.5]/5*temp)

% 配色参数
primaryColor = [0.2980, 0.4470, 0.7410]; % 蓝色
secondaryColor = [0.8500, 0.3250, 0.0980]; % 橙色
accentColor = [0.4660, 0.6740, 0.1880]; % 绿色
markerColorFactor = 0.7; % 标记颜色因子

% 绘制航迹
% plot3(droneyee3_states_d(251:end - 250, 1), droneyee3_states_d(251:end - 250, 2), ones(len - 500, 1), "LineWidth", 2, "LineStyle", "-", 'Color', secondaryColor)
% hold on
plot(droneyee3_states_d(1:3000, 1), droneyee3_states_d(1:3000, 2), "LineWidth", 4, "LineStyle", "-", 'Color', secondaryColor)
hold on
% 绘制平滑后的航迹
plot(smoothed_data(indices, 1), smoothed_data(indices, 2), "LineWidth", 2, "LineStyle", "-.", 'Color', [primaryColor]*markerColorFactor)%, 'Marker',"o","Markersize", 4, 'MarkerIndices', markerindices,'MarkerEdgeColor',[primaryColor]*markerColorFactor)
hold on
% 绘制起始点
plot(droneyee3_states(start_time, 1), droneyee3_states(start_time, 2),"o","Markersize", 8, 'MarkerFaceColor', 'b','MarkerEdgeColor','b')
hold on
% 绘制终点
plot(droneyee3_states(end_time, 1), droneyee3_states(end_time, 2),"d","Markersize", 8, 'MarkerFaceColor','r','MarkerEdgeColor','r')
hold on

xlim([-2, 2]);
ylim([-1.8, 2.2]);

legend('Detection region','Buffer region', 'Obstacle region','Reference trj', 'Quadrotor trj', 'Take-off point', 'Land point', 'Fontname', 'times new Roman', 'fontsize', 14, 'Orientation', 'horizontal', 'location', 'North', 'NumColumns', 3,'box','off')
xlabel('X-axis', 'Fontname', 'times new Roman', 'fontsize', 16)
ylabel('Y-axis', 'Fontname', 'times new Roman', 'fontsize', 16)
% title('Trajectory of Quadrotor', 'Fontname', 'times new Roman', 'fontsize', 16)

grid on
axis normal;
axis equal; % 设置坐标轴比例相等，保证球体的形状正确显示
ax = gca;
ax.GridLineStyle = '--';

if tightfig_flag == 1
    tightfig;
end
if savefig_flag == 1
    saveas(5, ['x_y', time, '.fig'])
    saveas(5, ['x_y', time, '.eps'],'psc')
    saveas(5, ['x_y', time, '.pdf'])
end

cd(path);

%%
% figure(6)
% cd(path1);
% set(gcf, 'Units', 'centimeter', 'Position', [5 5 20 10]);
% subplot(2, 1, 1)
% figure('position', Figure_size_1)
% plot(t, droneyee3_states_d(:, 1) - droneyee3_states(:, 1), "LineWidth", 2, "LineStyle", "-", "Color", 'b')
% xlim([0, t(end)])
% ylim([-2.5, 1.5])
% legend('$e_{X}$', 'Fontname', 'times new Roman', 'Location', 'Southeast', 'fontsize', 12,'interpreter','latex')
% xlabel('time [s]', 'Fontname', 'times new Roman', 'fontsize', 14)
% ylabel('Error of X-axis', 'Fontname', 'times new Roman', 'fontsize', 14)
% % title('X-axis tracking error','Fontname','times new Roman','fontsize',16)
% grid on
% axis normal;

% subplot(2, 1, 2)
% plot(t, droneyee3_states_d(:, 2) - droneyee3_states(:, 2), "LineWidth", 2, "LineStyle", "-", "Color", 'b')
% xlim([0, t(end)])
% ylim([-2.5, 1.5])
% legend('$e_{Y}$', 'Fontname', 'times new Roman', 'Location', 'Southeast', 'fontsize', 12,'interpreter','latex')
% xlabel('time [s]', 'Fontname', 'times new Roman', 'fontsize', 14)
% ylabel('Error of Y-axis', 'Fontname', 'times new Roman', 'fontsize', 14)
% % title('Y-axis tracking error','Fontname','times new Roman','fontsize',16)
% grid on
% axis normal;
% if tightfig_flag == 1
%     tightfig;
% end
% if savefig_flag == 1
%     saveas(6, ['error', time, '.fig'])
%     saveas(6, ['error', time, '.eps'],'psc')
% end

% cd(path);

% %%
% figure(7)
% cd(path1);
% set(gcf, 'Units', 'centimeter', 'Position', [5 5 20 10]);
% subplot(2, 1, 1)
% figure('position', Figure_size_1)
% alpha = 0.25;
% plot(t, droneyee3_states_d(:, 1), "LineWidth", 2, "LineStyle", "-", 'Color', [1, 0.5, 0])
% hold on
% % plot(t,droneyee3_states(:,1),"LineWidth",2.5,"LineStyle","-",'Color', [0.5 0.5 0.5])
% % plot(t,droneyee3_states(:,1),"LineWidth",2,"LineStyle","-",'Color', [0 0 0])
% plot(t, droneyee3_states(:, 1), "LineWidth", 2, "LineStyle", "-", 'Color', [alpha alpha alpha])
% xlim([0, t(end)])
% ylim([-2, 3.2])
% legend('$p_{d,X}$', '$p_{X}$', 'Fontname', 'times new Roman', 'Location', 'northeast', 'fontsize', 12, 'Orientation', 'Horizontal','interpreter','latex')
% xlabel('time [s]', 'Fontname', 'times new Roman', 'fontsize', 14)
% ylabel('Position of X-axis', 'Fontname', 'times new Roman', 'fontsize', 14)
% % title('X-axis tracking error','Fontname','times new Roman','fontsize',16)
% grid on
% axis normal;

% subplot(2, 1, 2)
% plot(t, droneyee3_states_d(:, 2), "LineWidth", 2, "LineStyle", "-", 'Color', [1, 0.5, 0])
% hold on
% % plot(t,droneyee3_states(:,2),"LineWidth",2.5,"LineStyle","-",'Color', [0.5 0.5 0.5])
% % plot(t,droneyee3_states(:,2),"LineWidth",2,"LineStyle","-",'Color', [0 0 0])
% plot(t, droneyee3_states(:, 2), "LineWidth", 2, "LineStyle", "-", 'Color', [alpha alpha alpha])
% xlim([0, t(end)])
% ylim([-2, 3.2])
% legend('$p_{d,Y}$', '$p_{Y}$', 'Fontname', 'times new Roman', 'Location', 'northeast', 'fontsize', 12, 'Orientation', 'Horizontal','interpreter','latex')
% xlabel('time [s]', 'Fontname', 'times new Roman', 'fontsize', 14)
% ylabel('Position of Y-axis', 'Fontname', 'times new Roman', 'fontsize', 14)
% % title('Y-axis tracking error','Fontname','times new Roman','fontsize',16)
% grid on
% axis normal;
% if tightfig_flag == 1
%     tightfig;
% end
% if savefig_flag == 1
%     saveas(7, ['position', time, '.fig'])
%     saveas(7, ['position', time, '.eps'],'psc')
% end

% cd(path);

%%

figure('position', Figure_size_1)
len = length(droneyee3_states_d(:, 3));

% 采样间隔
sampling_interval = 50;
% 获取每隔 sampling_interval 个数据点的索引
indices = 1:sampling_interval:length(droneyee3_states(:, 1));
% temp = 4;
% % plot3(droneyee3_states_d(:,1),droneyee3_states_d(:,2),(-droneyee3_states_d(:,3)+1)/2,"LineWidth",2,"LineStyle","-",'Color', [1, 0.5, 0])
% plot3(droneyee3_states_d(251:end - 250, 1), droneyee3_states_d(251:end - 250, 2), ones(len - 500, 1), "LineWidth", 3, "LineStyle", "-", 'Color', [1, 0.5, 0])
% hold on
% plot3(droneyee3_states(:, 1), droneyee3_states(:, 2), -droneyee3_states(:, 3), "LineWidth", 1.5, "LineStyle", "-", 'Color', [0.5 0.5 0.5]/5*temp);%,'Marker','o',"Markersize", 4, "LineWidth", 1, 'Color', [0.5 0.5 0.5]/5*temp,'MarkerIndices',indices)
% hold on
% plot3(droneyee3_states(1, 1), droneyee3_states(1, 2), -droneyee3_states(1, 3), "o", 'MarkerFaceColor', 'blue', "LineWidth", 0.1, 'MarkerSize', 7) % 'Take-off point'
% hold on
% plot3(droneyee3_states(end, 1), droneyee3_states(end, 2), -droneyee3_states(end, 3), "o", 'MarkerFaceColor', 'red', "LineWidth", 0.1, 'MarkerSize', 7) % 'Land point'
% hold on


% 配色参数
primaryColor = [0.2980, 0.4470, 0.7410]; % 蓝色
secondaryColor = [0.8500, 0.3250, 0.0980]; % 橙色
accentColor = [0.4660, 0.6740, 0.1880]; % 绿色
markerColorFactor = 0.7; % 标记颜色因子

% 绘制航迹
plot3(droneyee3_states_d(251:end - 250, 1), droneyee3_states_d(251:end - 250, 2), ones(len - 500, 1), "LineWidth", 3, "LineStyle", "-", 'Color', secondaryColor)
hold on
% 绘制平滑后的航迹
plot3(smoothed_data(:, 1), smoothed_data(:, 2), -smoothed_data(:, 3), "LineWidth", 1.5, "LineStyle", "-.", 'Color', [primaryColor]*markerColorFactor)%, 'Marker',"o","Markersize", 4, 'MarkerIndices', markerindices,'MarkerEdgeColor',[primaryColor]*markerColorFactor)
hold on
% 绘制起始点
plot3(droneyee3_states(1, 1), droneyee3_states(1, 2), -droneyee3_states(1, 3),"o","Markersize", 10, 'MarkerFaceColor', 'b','MarkerEdgeColor','b')
hold on
% 绘制终点
plot3(smoothed_data(end, 1), smoothed_data(end, 2), -smoothed_data(end, 3),"d","Markersize", 10, 'MarkerFaceColor','r','MarkerEdgeColor','r')
hold on

delta = 1/30;
t1 = 28 / delta;
t2 = 44.4 / delta;
t3 = 62.8 / delta;
t4 = 75.7 / delta;
plot3(droneyee3_states(t1, 1), droneyee3_states(t1, 2), -droneyee3_states(t1, 3), "o", 'MarkerFaceColor', 'green', "LineWidth", 0.1, 'MarkerSize', 10) % 'Land point'
hold on
plot3(droneyee3_states(t2, 1), droneyee3_states(t2, 2), -droneyee3_states(t2, 3), "o", 'MarkerFaceColor', 'yellow', "LineWidth", 0.1, 'MarkerSize', 10) % 'Land point'
hold on
plot3(droneyee3_states(t3, 1), droneyee3_states(t3, 2), -droneyee3_states(t3, 3), "o", 'MarkerFaceColor', 'cyan', "LineWidth", 0.1, 'MarkerSize', 10) % 'Land point'
hold on
plot3(droneyee3_states(t4, 1), droneyee3_states(t4, 2), -droneyee3_states(t4, 3), "o", 'MarkerFaceColor', 'magenta', "LineWidth", 0.1, 'MarkerSize', 10) % 'Land point'
hold on
xlim([-1.8,1.6])
zlim([0, 1.2])


% 定义球体的参数
radius = ro; % 球体半径
center = [x1, y1, 1]; % 球体中心坐标
% 生成球体表面上的点
theta = linspace(0, 2*pi, 100); % 极角
phi = linspace(0, pi, 50); % 方位角
[theta, phi] = meshgrid(theta, phi);
x = center(1) + radius * sin(phi) .* cos(theta);
y = center(2) + radius * sin(phi) .* sin(theta);
z = center(3) + radius * cos(phi);
h=surf(x, y, z, 'FaceColor', [0.7, 0.1, 0.1], 'EdgeColor',  [0.7, 0.1, 0.1], 'FaceAlpha', 1, 'EdgeAlpha', 1, 'LineStyle', '-','LineWidth',3);
C = z;
h.CData = C;
h.FaceColor = 'interp';
h.EdgeColor = 'none';
% colormap(gray);
% colormap('bone');
colormap('copper');
hold on

% 定义球体的参数
radius = ra; % 球体半径
center = [x1, y1, 1]; % 球体中心坐标
num_points = 30; % 球面上的点数量
% 生成球体表面上的点
theta = linspace(0, 2*pi, num_points*2); % 极角
phi = linspace(0, pi, num_points); % 方位角
[theta, phi] = meshgrid(theta, phi);
x = center(1) + radius * sin(phi) .* cos(theta);
y = center(2) + radius * sin(phi) .* sin(theta);
z = center(3) + radius * cos(phi);
plot3(x, y, z, 'Color', [1, 0.8, 0.8]); % 绘制球面
for i = 1:num_points
    % plot3(x(:,i), y(:,i), z(:,i), 'Color', [1, 0.7, 0.7]); % 绘制经线
    plot3(x(i,:), y(i,:), z(i,:), 'Color', [1, 0.8, 0.8]); % 绘制纬线
end
% surf(x, y, z, 'FaceColor', [1.00,0.80,0.80], 'EdgeColor',  [1.00,0.80,0.80], 'FaceAlpha', 0.3, 'EdgeAlpha', 0, 'LineStyle', '-','LineWidth',3);
hold on

% 定义球体的参数
radius = rd; % 球体半径
center = [x1, y1, 1]; % 球体中心坐标
num_points = 15; % 球面上的点数量
% 生成球体表面上的点
theta = linspace(0, 2*pi, num_points*2); % 极角
phi = linspace(0, pi, num_points); % 方位角
[theta, phi] = meshgrid(theta, phi);
x = center(1) + radius * sin(phi) .* cos(theta);
y = center(2) + radius * sin(phi) .* sin(theta);
z = center(3) + radius * cos(phi);
plot3(x, y, z, 'Color', [0.7, 0.7, 1]); % 绘制球面
for i = 1:num_points
    % plot3(x(:,i), y(:,i), z(:,i), 'Color', [0.7, 0.7, 1]); % 绘制经线
    plot3(x(i,:), y(i,:), z(i,:), 'Color', [0.7, 0.7, 1]); % 绘制纬线
end
hold on

legend('Reference trajactory', 'Quadrotor trajactory', 'Take-off point', 'Land point', '28.0s', '44.4s', '62.8s', '75.7s', 'Fontname', 'times new Roman', 'fontsize', 14, 'Orientation', 'vertical', 'location', 'North', 'NumColumns', 4,'box','off')
% legend('Take-off point','Land point','28.0s','44.4s','62.8s','75.7s','DMP-based trajactory','Quadrotor trajactory','Fontname','times new Roman','fontsize',12,'Orientation','horizontal','location','North','NumColumns', 3)
xlabel('X-axis', 'Fontname', 'times new Roman', 'fontsize', 16)
ylabel('Y-axis', 'Fontname', 'times new Roman', 'fontsize', 16)
zlabel('Z-axis', 'Fontname', 'times new Roman', 'fontsize', 16)
% title('Trajectory of Quadrotor','Fontname','times new Roman','fontsize',16)
grid on
axis normal;
axis equal; % 设置坐标轴比例相等，保证球体的形状正确显示
view(-6, 30);
if tightfig_flag == 1
    tightfig;
end
if savefig_flag == 1
    saveas(8, ['x_y_z', time, '.fig'])
    saveas(8, ['x_y_z', time, '.eps'],'psc')
    saveas(8, ['x_y_z', time, '.pdf'])
end

cd(path);


%%

figure('position', Figure_size_1)

P_wp1 = [0; 0]; % target location

x1 = Cache1(end, 6) + P_wp1(1); y1 = Cache1(end, 7) + P_wp1(2); % the position of obstacle
x2 = Cache1(end, 8) + P_wp1(1); y2 = Cache1(end, 9) + P_wp1(2); % the position of obstacle

ro = Cache1(end, 1); % the radius of obstacle
ra = Cache1(end, 2); % the radius of obstacle
rd = Cache1(end, 3); % Detection radius

% 采样间隔
sampling_interval = 1;
% 获取每隔 sampling_interval 个数据点的索引
indices = 1:sampling_interval:length(droneyee3_states(:, 1));
temp = 2;
% 采样间隔
sampling_interval2 = 180;
% 获取每隔 sampling_interval 个数据点的索引
indices2 = 1:sampling_interval2:length(droneyee3_states(:, 1));
% 选择平滑窗口大小
window_size = 60;
% 使用移动平均进行平滑处理
smoothed_data = movmean(droneyee3_states, window_size);

% 绘制数据
distance1 = [];
distance2 = [];
for i = 1:length(t)
    distance1 = [distance1; norm(smoothed_data(i, 1:2) - [x1,y1])];
    distance2 = [distance2; norm(droneyee3_states_d(i, 1:2) - [x1,y1])];
end

% plot(t(indices), distance2(indices),'r-','LineWidth',1.5)%,'Marker','*','MarkerIndices',indices2,'MarkerSize',4)
% hold on
% plot(t(indices), distance1(indices),'b-','LineWidth',1.5,'Marker','o','MarkerIndices',indices2,'MarkerSize',4,'MarkerEdgeColor','auto')
% hold on
% yline(ro,'LineStyle','-','LineWidth',2,'Color',[0.7, 0.1, 0.1])
% hold on
% % yline(ra,'LineStyle','-.','LineWidth',1.5,'Color',[1, 0.7, 0.7])
% yline(ra,'LineStyle','-.','LineWidth',2,'Color',[0.8, 0.4, 0.4])
% hold on
% % yline(rd,'LineStyle','--','LineWidth',1.5,'Color',[0.1, 0.1, 0.7])
% yline(rd,'LineStyle','--','LineWidth',2,'Color',[0.4, 0.4, 0.8])
% grid on
% % axis equal
% % xlim([-2, 2]);
% ylim([0, 3.3]);
% legend('$\|d_{ref}(t)\|$','$\|d(t)\|$', '$r_1$','$R_1$', '$D_1$', 'interpreter', 'latex','Fontname', 'times new Roman', 'fontsize', 12, 'Orientation', 'horizontal', 'location', 'North', 'Box', 'off')
% xlabel('time [s]', 'Fontname', 'times new Roman', 'fontsize', 16)
% ylabel('distance(m)', 'Fontname', 'times new Roman', 'fontsize', 16)
% % title('Distance to obstacle', 'Fontname', 'times new Roman', 'fontsize', 16)
% grid on
% % axis normal;
fill([t(indices(1)) t(indices(end)) t(indices(end)) t(indices(1))], [0 0 ro ro], [0.8, 0.2, 0.2], 'FaceAlpha', 0.5, 'EdgeColor', 'none')
% fill([t(indices(1)) t(indices(end)) t(indices(end)) t(indices(1))], [0 0 ro ro], [1.0, 1.0, 0.3], 'FaceAlpha', 0.5, 'EdgeColor', 'none')

hold on

% 第二个矩形填充
fill([t(indices(1)) t(indices(end)) t(indices(end)) t(indices(1))], [ro ro ra ra], [0.8, 0.2, 0.2], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
hold on

% 第三个矩形填充
fill([t(indices(1)) t(indices(end)) t(indices(end)) t(indices(1))], [rd rd ra ra], [0.4, 0.6, 0.8], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
hold on

% 水平实线
yline(ro, 'LineStyle', '-', 'LineWidth', 2, 'Color', [0.9, 0.3, 0.3])
% yline(ro, 'LineStyle', '-', 'LineWidth', 2, 'Color', [0.3, 0.3, 0.4])
hold on
% 水平虚线
yline(ra, 'LineStyle', '--', 'LineWidth', 2, 'Color', [0.9, 0.3, 0.3])
hold on
% 水平虚线
yline(rd, 'LineStyle', '-.', 'LineWidth', 2, 'Color', [0.3, 0.3, 0.9])
hold on

% 第一条曲线
plot(t(indices), distance2(indices), 'k-', 'LineWidth', 1.5, 'Marker', 'o', 'MarkerIndices', indices2, 'MarkerSize', 8, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', [0.8, 0.2, 0.2])
hold on

% 第二条曲线
plot(t(indices), distance1(indices), 'b-', 'LineWidth', 1.5, 'Marker', 'x', 'MarkerIndices', indices2, 'MarkerSize', 10, 'MarkerEdgeColor', 'auto', 'MarkerFaceColor', [0.4, 0.6, 0.8])
hold on

grid on
% axis equal

xlim([0, t(end_time)-t(start_time)])
ylim([0, 3.6]);

legend('Obstacle region $O_i$', 'Buffer region $A_i$', 'Detection region $D_i$', 'Obstacle radius $r_{o,i}$', 'Buffer radius $R_{o,i}$', 'Detection radius $D_{o,i}$', '$\|d_1(t)\|$', '$\|d_2(t)\|$', 'interpreter', 'latex','Fontname', 'times new Roman', 'fontsize', 14, 'Orientation', 'vertical', 'location', 'North', 'Box', 'off', 'numcolumns', 3)
xlabel('time [s]', 'Fontname', 'times new Roman', 'fontsize', 16)
ylabel('distance(m)', 'Fontname', 'times new Roman', 'fontsize', 16)
% title('Distance to obstacle', 'Fontname', 'times new Roman', 'fontsize', 16)

grid on
% axis normal;

if tightfig_flag == 1
    tightfig;
end
if savefig_flag == 1
    saveas(9, ['distance', time, '.fig'])
    saveas(9, ['distance', time, '.eps'],'psc')
    saveas(9, ['distance', time, '.pdf'])
end

cd(path);


%% 

figure('position', Figure_size_1)

P_wp1 = [0; 0]; % target location

x1 = Cache1(end, 6) + P_wp1(1); y1 = Cache1(end, 7) + P_wp1(2); % the position of obstacle
x2 = Cache1(end, 8) + P_wp1(1); y2 = Cache1(end, 9) + P_wp1(2); % the position of obstacle

ro = Cache1(end, 1); % the radius of obstacle
ra = Cache1(end, 2); % the radius of obstacle
rd = Cache1(end, 3); % Detection radius

% 采样间隔
sampling_interval = 1;
% 获取每隔 sampling_interval 个数据点的索引
indices = 1:sampling_interval:length(droneyee3_states(:, 1));
temp = 2;
% 采样间隔
sampling_interval2 = 90;
% 获取每隔 sampling_interval 个数据点的索引
indices2 = 1:sampling_interval2:length(droneyee3_states(:, 1));
% 选择平滑窗口大小
window_size = 60;
% 使用移动平均进行平滑处理
smoothed_data = movmean(droneyee3_states, window_size);

% 绘制数据
zk_ = [x1 y1; x2 y2];
s = [];L1 = 0.3; L2 = 0.8; L3 = 0.2;

for j = 1:length(t)
    temp = 0;
    for i = 1:length(zk_)
        zk = zk_(i,:);
        dk = norm(droneyee3_states(j, 1:2)-zk);
        if dk > rd
            sk = 0;
            dsk = [0;0];
        elseif dk >ra
            sk = L1 + L1 * cos(pi*(dk^2 - ra^2)/(rd^2 - ra^2));
        elseif dk > ro
            sk = L2 + L3 * cos(pi*(dk^2 - ro^2)/(ra^2 - ro^2));
        else
            sk = 1;
        end
        temp = temp + sk;
    end
    s = [s; temp];
end

plot(t, s,'r-','LineWidth',1.5)%,'Marker','*','MarkerIndices',indices2,'MarkerSize',4)
hold on
% plot(t(indices), distance1(indices),'b-','LineWidth',1.5,'Marker','o','MarkerIndices',indices2,'MarkerSize',4,'MarkerEdgeColor','auto')
% hold on
% yline(ro,'LineStyle','-','LineWidth',2,'Color',[0.7, 0.1, 0.1])
% hold on
% % yline(ra,'LineStyle','-.','LineWidth',1.5,'Color',[1, 0.7, 0.7])
% yline(ra,'LineStyle','-.','LineWidth',2,'Color',[0.8, 0.4, 0.4])
% hold on
% % yline(rd,'LineStyle','--','LineWidth',1.5,'Color',[0.1, 0.1, 0.7])
% yline(rd,'LineStyle','--','LineWidth',2,'Color',[0.4, 0.4, 0.8])

grid on
% axis equal

% xlim([-2, 2]);
% ylim([0, 3.3]);

legend('$\|d_{ref}(t)\|$','$\|d(t)\|$', '$r_1$','$R_1$', '$D_1$', 'interpreter', 'latex','Fontname', 'times new Roman', 'fontsize', 12, 'Orientation', 'horizontal', 'location', 'North', 'Box', 'off')
xlabel('time [s]', 'Fontname', 'times new Roman', 'fontsize', 16)
ylabel('distance(m)', 'Fontname', 'times new Roman', 'fontsize', 16)
% title('Distance to obstacle', 'Fontname', 'times new Roman', 'fontsize', 16)

grid on
% axis normal;


if tightfig_flag == 1
    tightfig;
end
if savefig_flag == 1
    saveas(10, ['sx', time, '.fig'])
    saveas(10, ['sx', time, '.eps'],'psc')
    saveas(10, ['sx', time, '.pdf'])
end

cd(path);

%% 计算

