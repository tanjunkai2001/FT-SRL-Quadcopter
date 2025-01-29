% 假设smoothed_data是一个N行3列的矩阵,每一行存储一个(x,y,z)坐标
total_distance_quadrotor = 0;
total_distance_reference = 0;

% 遍历每一对相邻的坐标点
for i = 1:size(smoothed_data,1)-1 
    % 计算当前点与下一点之间的欧氏距离
    distance_quadrotor = sqrt(sum((smoothed_data(i,1:3)-smoothed_data(i+1,1:3)).^2));
    % 累加到总路径长度
    total_distance_quadrotor = total_distance_quadrotor + distance_quadrotor;
end
for i = 1:size(droneyee3_states_d,1)-1
    % 计算当前点与下一点之间的欧氏距离
    distance_reference = sqrt(sum((droneyee3_states_d(i,1:3)-droneyee3_states_d(i+1,1:3)).^2));
    % 累加到总路径长度
    total_distance_reference = total_distance_reference + distance_reference;
end

disp(['总路径长度为: ', num2str(total_distance_quadrotor)]);

disp(['相对路径长度为: ', num2str(total_distance_quadrotor/total_distance_reference)]);