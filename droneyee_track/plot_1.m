
% % x,y
% figure
% plot(droneyee1_states_d(:,1:2),'DisplayName','droneyee1_states_d(:,1:2)')
% hold on
% plot(droneyee1_states(:,1:2),'DisplayName','droneyee1_states(:,1:2)')
% 
% % x
% figure
% plot(droneyeecar1_states_d(:,1))
% hold on
% plot(droneyeecar1_states(:,1))
% 
% % y
% figure
% plot(droneyeecar1_states_d(:,2))
% hold on
% plot(droneyeecar1_states(:,2))
% 
% % x-y
% figure
% plot(droneyeecar1_states_d(:,1),droneyeecar1_states_d(:,2))
% hold on 
% plot(droneyeecar1_states(:,1),droneyeecar1_states(:,2))

%% 
close all
path = pwd;
time = datestr(now, 'yymmdd-HH_MM');
%%
% x
figure
plot(droneyee3_states_d(:,1))
hold on
plot(droneyee3_states(:,1))
cd('test_trj')
saveas(1,['state1_',time,'.fig'])
saveas(1,['state1_',time,'.jpg'])
cd(path)
% y
figure
plot(droneyee3_states_d(:,2)) 
hold on
plot(droneyee3_states(:,2))
cd('test_trj')
saveas(2,['state2_',time,'.fig'])
saveas(2,['state2_',time,'.jpg'])
cd(path)
% x-y
figure
plot(droneyee3_states_d(:,1),droneyee3_states_d(:,2))
hold on
plot(droneyee3_states(:,1),droneyee3_states(:,2))
cd('test_trj')
saveas(3,['states_2dim_',time,'.fig'])
saveas(3,['states_2dim_',time,'.jpg'])
cd(path)

%%
cd('data')
save(['workspace_',time,'.mat'])
cd(path)