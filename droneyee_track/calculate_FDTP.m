% 假设smoothed_data是一个N行3列的矩阵,每一行存储一个(x,y,z)坐标
% 假设droneyee3_states_d是期望轨迹数据,最后一行存储终点坐标

% final_position = [smoothed_data(end,1:2),1]; % 无人机最后的位置
% target_position = droneyee3_states_d(end,1:3); % 期望轨迹的终点位置
final_position = smoothed_data(end_time,1:3); % 无人机最后的位置
target_position = droneyee3_states_d(end_time,1:3); % 期望轨迹的终点位置

% 计算最后的位置到终点的欧氏距离
distance = sqrt(sum((final_position - target_position).^2));

disp(['最后的位置到期望轨迹终点的距离为: ', num2str(distance)]);