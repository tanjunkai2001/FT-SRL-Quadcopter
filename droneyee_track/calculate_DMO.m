% 假设smoothed_data是一个N行3列的矩阵,每一行存储一个(x,y,z)坐标
% 定义球体的参数
radius = ro; % 球体半径
center = [x1, y1, -1]; % 球体中心坐标
min_distance_obstacle1 = Inf; % 初始化最小距离为无穷大

for i = 1:size(smoothed_data,1)
    
    % 计算当前点到障碍物中心的欧氏距离
    distance = sqrt(sum((smoothed_data(i,1:3)-center).^2));
    
    % 更新最小距离
    if distance < min_distance_obstacle1
        min_distance_obstacle1 = distance;
    end
    
end

disp(['最小距离为: ', num2str(min_distance_obstacle1)]);
disp(['相对最小距离为: ', num2str(min_distance_obstacle1/ro)]);

%% obstacle 2
% 定义球体的参数
radius = ro; % 球体半径
center = [x2, y2, -1]; % 球体中心坐标
min_distance_obstacle2 = Inf; % 初始化最小距离为无穷大

for i = 1:size(smoothed_data,1)
    
    % 计算当前点到障碍物中心的欧氏距离
    distance = sqrt(sum((smoothed_data(i,1:3)-center).^2));
    
    % 更新最小距离
    if distance < min_distance_obstacle2
        min_distance_obstacle2 = distance;
    end
    
end

disp(['最小距离为: ', num2str(min_distance_obstacle2)]);
disp(['相对最小距离为: ', num2str(min_distance_obstacle2/ro)]);