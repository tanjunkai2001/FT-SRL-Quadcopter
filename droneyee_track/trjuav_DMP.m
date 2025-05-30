function [x,y,z] =trjuav_DMP(timestamp,num,flagg,stat,trj_flag,form_flag,avo_flag,ref)
point_time=0; % 开始时间
zstart=-0.5;
% w1=0.1;
% w2=0.1;
% k=1;
% bb=1;
% a=1;
% b=1;
% sim_end_time=600;
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
%% 定义&初始化 持久变量
persistent time_start ts td x0 y0;
    % persistent x1_t0 ;
    % persistent y1_t0 ;
persistent n;
%  X_origin=0;
%  Y_origin=0;
%  Z_origin=0;
% persistent var1 ... varN 将变量 var1 ... varN 声明为持久变量。持久变量是声明它们的函数的局部变量；但其值保留在对该函数的各次调用所使用的内存中。MATLAB命令行和其他函数中的代码不能更改持久变量。
% 当 MATLAB 首次遇到特定 persistent 语句时，它将持久变量初始化为空矩阵 ([])。
if isempty(time_start)
     time_start = timestamp;
end

if isempty(ts)
     ts = 0;
end

if isempty(td)
     td = 0; 
end

if isempty(n)
     n =1;
end

if isempty(x0)
     x0=stat(1);
end

if isempty(y0)
     y0 =stat(2);
end


%% 本段代码用于计算不同飞行状态的时间持续长度，以便生成reference trajectory
if flagg<=1 || (ts+td< point_time) % flagg<=1：hover or land
    td=timestamp-ts; % 距离上一次切换状态的时间间隔
    t=ts; % 默认hover和land情况下，t==0
else % flagg>1：trj
    ts=timestamp-td; % 切换到当前trj状态的持续时间长度
    t=ts; % 将ts传递给时间t
    n=n+1;
    
end
% 
% if ts+td< point_time
%     x=x0;
%     y=y0;
%     z=zstart;
% elseif flagg==1
%     x=x0;
%     y=y0;
%     z=-1;
% else
%%%%%%%%%%%%%%%%%%%%%cic%%%%%%%%%%%%%%%%%%%%    
 r=1.5;
 w=0.1;
%  x=r*cos(w*t+num*2*pi/4);
%  y=r*sin(w*t+num*2*pi/4);
 z=-1;
 
x0 =stat(1);
y0 =stat(2);
dis_max = norm(ref(end,:));
len = length(ref);
acc = 4;
% if n*acc < len
%     x = ref(n*acc,1)/dis_max*r*1;%-r;
%     y = ref(n*acc,2)/dis_max*r*1;%-r;
% else
%     x = ref(len,1)/dis_max*r*1;%-r;
%     y = ref(len,2)/dis_max*r*1;%-r;
% end
if n*acc < len
    x = ref(n*acc,1)/dis_max*r*2-r;
    y = ref(n*acc,2)/dis_max*r*2-r;
else
    x = ref(len,1)/dis_max*r*2-r;
    y = ref(len,2)/dis_max*r*2-r;
end

%%%%%%%%%%%%%%%%%%%%%%%%   trj9  8shaped %%%%%%%%%%%%%%%%%%%%%%%%%



% a=1.4;
% b=0.7;
% bb=-1;
% w1=0.1;
% w2=0.2;
% x=a*cos(w1*t-num*pi/3);
% y=b*sin(w2*t-num*pi/3);
% z=0.1*y+bb;

% a=1.4;
% b=0.7;
% w2=0.1;
% w3=0.2;
% x=a*cos(w2*(t-7*(num-1)));
% y=b*sin(w3*(t-7*(num-1)));
% z=-0.8;
% % x0=stat(1);
% % y0 =stat(2);
% % end

% if (t - time_start) < point_time
%     t = 0;
%     n=1;
% elseif (sim_end_time - timestamp) >=3
%     t = timestamp-point_time- time_start;
%     else
%     t = sim_end_time - 3;
% end



% tb=5.4;
% a=1.4;
% b=0.7;
% bb=-1;
% w1=0.1;
% w2=0.2;
% x=b*sin(w2*(t-(num-1)*tb));
% y=a*cos(w1*(t-(num-1)*tb));
% z=0.1*y+bb;


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%triangle%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%triangle%%%
% pgap=1.5;  %%distance betwen two uavs
% vel=0.3;  %%velocity
% clen=1.5;  %%edge length of triangle
%  
%  
% tgap=pgap/vel;
% a=floor((t+(num-1)*tgap)/(clen/vel));
%  
% b=mod(a,3);
% c=mod((t+(num-1)*tgap),clen/vel);
%  
% if b==0
%   
%     x=clen/2-0.5*vel*mod((t+(num-1)*tgap),clen/vel);
%     y= -1.732*x+clen/1.732;
% elseif b==1
%     x=-0.5*vel*mod((t+(num-1)*tgap),clen/vel);
%     y= 1.732*x+clen/1.732;
% else
%     x=-clen/2+vel*mod((t+(num-1)*tgap),clen/vel);
%     y= -clen/3.464;
% %figure(1);
%  
% end
% z=-1;
 
 




%%%%%%%%%%%%%%%%%%%%%%%%%%  squ  %%%%%%%%%%%%%%%%%%%%%%%%%


% pgap=1.5;
% vel=0.3;
% clen=1.5;
% tgap=pgap/vel;
% 
% a=floor((t+(num-1)*tgap)/(clen/vel));
% 
% b=mod(a,4);
% c=mod((t+(num-1)*tgap),clen/vel);
% 
% if b==0
%     
%     x=clen/2-vel*mod((t+(num-1)*tgap),clen/vel);
%     y= -clen/2;
% elseif b==1
%     y=-clen/2+vel*mod((t+(num-1)*tgap),clen/vel);
%     x= -clen/2;
% elseif b==2
%     x=-clen/2+vel*mod((t+(num-1)*tgap),clen/vel);
%     y= clen/2;
% elseif b==3
%     y=clen/2-vel*mod((t+(num-1)*tgap),clen/vel);
%     x= clen/2;
% else
%     x=clen/2-vel*mod((t+(num-1)*tgap),clen/vel);
%     y= -clen/2;
% end

% z=-1;










%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         w1=0.025;                                          %
%         w2=0.1;
%         k=2;
%         bb=1;
%         a=3;
%         b=3;
% 
% 
%         totol_n=25;                               %
%         
%         t=t-(num-1)*4*pi/totol_n/w2;
%             x = (-0.5*sin(w1*t)+1.5+a)*cos(w2*t); %
%             y = (-0.5*sin(w1*t)+1.5+b)*sin(w2*t); %
%             z =k*cos(w1*t)+bb;                    %
%                %%%%% trj1_____spirl%%%%%%%%%%%% 
% %                %%%%% trj1_____spirl%%%%%%%%%%%% 
% %                %%%%% trj1_____spirl%%%%%%%%%%%% 




%%%%%%%%%%%%%%%%%%%%% trj1---- 8VS16 ellipse%%%%%%%%%%%% %
%%%%%%%%%%%%%%%%%%%%% trj1---- 8VS16 ellipse%%%%%%%%%%%% %
%%%%%%%%%%%%%%%%%%%%% trj1---- 8VS16 ellipse%%%%%%%%%%%% %
%%%%%%%%%%%%%%%%%%%%% trj1---- 8VS16 ellipse%%%%%%%%%%%% %
%         if num<=8
% %             w1=0.1; %%  up&down frequency         %
%             w2=0.15; %% rotation freq              %
% %             k=2;    %%%Z scale
%             bb=1;  %%%Z mid
%             a=2;   %%x scale
%             b=1 ;  %%y scale
%             a0=0;
%             b0=2.2;
%             totol_n=8;                            %
% 
%             t=t-(num-1)*2*pi/totol_n/w2;
%             x = a*cos(w2*t)+a0;                      %
%             y = b*sin(w2*t)+b0;                      %
%             z =bb;
% 
%         
%         
%         
%         
%         else
%             w1=0.1; %%  up&down frequency         %
%             w2=0.15; %% rotation freq              %
%             k=2;    %%%Z scale
%             bb=1;  %%%Z mid
%             a=2.5;   %%x scale
%             b=1.7 ;  %%y scale
%             a0=0;
%             b0=-1.3;
%             totol_n=16;                            %
% 
%             t=t-(num-1)*2*pi/totol_n/w2;
%             x = a*cos(w2*t)+a0;                      %
%             y = b*sin(w2*t)+b0;                      %
%             z =bb;
% 
%         end
%%%%%%%%%%%%%%%%%%%% trj1---- 8VS16 ellipse%%%%%%%%%%%% %
%%%%%%%%%%%%%%%%%%%% trj1---- 8VS16 ellipse%%%%%%%%%%%% %
%%%%%%%%%%%%%%%%%%%% trj1---- 8VS16 ellipse%%%%%%%%%%%% %
        
        
        
        






% %%%%%%%%%%%%%%%%%%%%%%%%   trj3  cross %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% %%%%%%%%%%%%%%%%%%%%%%%%   trj3  cross %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% %%%%%%%%%%%%%%%%%%%%%%%%   trj3  cross %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% %%%%%%%%%%%%%%%%%%%%%%%%   trj3  cross %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

%         w2=0.2;
%         a1=0;
%         b1=-2*(1-cos(w2*t));%%8ji��%%%%
%         bb1=1;
%         bb2=1;
%         a2=0;
%         b2=1.5*(1-cos(w2*t));%%16ji��%%%%
%         d1=5/3;
%         d2=5/3;
% 
% 
%         if num<3
%             x=d1*(2-num)+a1;
%             y=3+b1;
%             z=bb1;
%         elseif num <5
%             x=-1*d1+a1;
%             y=4-num+2+b1;
%             z=bb1;
%         elseif num <7
%             x=d1*(num-6)+a1;
%             y=1+b1;
%             z=bb1;
%         elseif num<=8
%             x=1*d1+a1;
%             y=num-8+2+b1;
%             z=bb1;
% 
% 
% 
% 
% 
%         elseif num<=12
%              x=d2*(num-10.5)+a2;
%              y=0+b2;
%              z=bb2;
% 
%         elseif num<=16
%             x=d2*(num-14.5)+a2;
%             y=-1+b2;
%             z=bb2;
% 
%         elseif num<=20 
%             x=d2*(num-18.5)+a2;
%             y=-2+b2;
%             z=bb2;
% 
%         else
%             x=d2*(num-22.5)+a2;
%             y=-3+b2;
%             z=bb2;
% 
%         end
%       
%%%%%%%%%%%%%%%%%%%%%%%%   trj3   cross %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%%%%%%%%%%%%%%%%%%%%%%   trj3   cross %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%%%%%%%%%%%%%%%%%%%%%%   trj3  cross %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%%%%%%%%%%%%%%%%%%%%%%   trj3  cross %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5






%%%%%%%%%%%%%%%%%%%%%%%%   trj4   wave %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%%%%%%%%%%%%%%%%%%%%%%   trj4   wave %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%%%%%%%%%%%%%%%%%%%%%%   trj4  wave %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%%%%%%%%%%%%%%%%%%%%%%   trj4  wave %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% w=0.5;
% dd=0.7;
% ap=0.4;
% if num==1
%     num=num+12;
% end
% if num<=8
%         
%         x=(num-4.5)*dd;
%         y=-2;
%         z=ap*sin(x*2*pi/5+w*t);
% elseif num <=16
%     num=num-8;
%         
%         x=(num-4.5)*dd;
%         y=1;
%         z=ap*sin(x*2*pi/5+w*t);
%       
% elseif num<=24
%     num=num-16;
%     
%         x=(num-4.5)*dd;
%         y=-1;
%         z=ap*sin(x*2*pi/5+w*t);
% else
%     num=num-24;
%     
%         x=(num-3.5)*dd;
%         y=-3;
%         z=ap*sin(x*2*pi/5+w*t);
% end
% z=z+1.3;
%%%%%%%%%%%%%%%%%%%%%%%%   trj4   wave %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%%%%%%%%%%%%%%%%%%%%%%   trj4   wave %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%%%%%%%%%%%%%%%%%%%%%%   trj4  wave %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%%%%%%%%%%%%%%%%%%%%%%   trj4  wave %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5



%%%%%%%%%%%%%%%%%%%%%%%%   trj5  2 circles %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%   trj5  2 circles %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%   trj5  2 circles %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%   trj5  2 circles %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%                         w=0.2;
%                     if num<=4
%                         z = -1;
%                         x = 1.2*cos(2*w*t+num*pi/2);
%                         y = 1.2*sin(2*w*t+num*pi/2);
%                     else
%                         num=num-4;
%                         z = 1;
%                         x = 2*cos(-w*t+num*pi/4);
%                         y = 2*sin(-w*t+num*pi/4);
%                     end
%%%%%%%%%%%%%%%%%%%%%%%%   trj5  2 circles %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%   trj5  2 circles %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%   trj5  2 circles %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%%%%%%%%%%%%%%%%%%%%%%%   trj6  spirl %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%   trj6  spirl %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%   trj6  spirl %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%   trj6  spirl %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%         w1=0.025;                                          %
%         w2=0.1;
%         k=2;
%         bb=1;
%         a=1;
%         b=1;
% 
% 
%         totol_n=25;                               %
%         
%         t=t+(num-1)*4*pi/totol_n/w2;
%             x = (-0.5*sin(w1*t)+1.5+a)*cos(w2*t); %
%             y = (-0.5*sin(w1*t)+1.5+b)*sin(w2*t); %
%             z =k*cos(w1*t)+bb; 
%%%%%%%%%%%%%%%%%%%%%%%%   trj6  spirl %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%   trj6  spirl %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%   trj6  spirl %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%   trj6  spirl %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%   trj7  rot circ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%   trj7  rot circ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%   trj7  rot circ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         totalnum=6;
%                         z = 1;
%                         r=1;
%                         r2=1.2;
%                         w1=0.1;
%                         w2=0.2;
%                         a0=r2*cos(w1*t);
%                         b0=r2*sin(w1*t);
%                         x = r*cos(w2*t+num*pi*2/totalnum)+a0;
%                         y = r*sin(w2*t+num*pi*2/totalnum)+b0;
%                         



%%%%%%%%%%%%%%%%%%%%%%%%   trj7  rot circ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%   trj7  rot circ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%   trj7  rot circ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%   trj7  rot circ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% %%%%%%%%%%%%%%%%%%%%%%%%   trj8  cross circ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%   trj8  cross circ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%   trj8  cross circ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% r=2;
% if num<=8
%         
%         x = r*cos(0.14*t-num*pi/4);
%         y = r*sin(0.14*t-num*pi/4)-1;
%         z = 1.3;
% elseif num <=16
%     num=num-8;
%         
%         y = r+1.5*cos(0.14*t-num*pi/3)-1;
%         z = 0.7*sin(0.14*t-num*pi/3);
%         x = z;
%         z = z+1.3;
% else
%     x=0;
%     y=0;
%     z=0;
% end

% %%%%%%%%%%%%%%%%%%%%%%%%   trj8  cross circ %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%   trj8  cross circ %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%   trj8  cross circ %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%   trj8  cross circ %%%%%%%%%%%%%%%%%%%%%%%%%













%%%% %%%%%%%%%%%%%%%%%%%%%%%   squ1  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% 
%                         z = -1;
% if n<300  %%%10s 
%                         x =-1;
%                         y =-1;
% elseif n<600
%     x=1;
%     y=-1;
% elseif n<900
%     x=1;
%     y=1;
% elseif n<1200
%     x=-1;
%     y=1;
% else
%     x=-1;
%     y=1;
%     n=1;
% end
%%%% %%%%%%%%%%%%%%%%%%%%%%%   squ1  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5


%%%% %%%%%%%%%%%%%%%%%%%%%%%   squ2  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% % % if num==5
% % %     num=4;
% % % end


% pgap=10;
% vel=0.5;
% clen=10;
% tgap=pgap/vel;
% 
% a=floor((t+(num-1)*tgap)/(clen/vel));

% b=mod(a,4);
% c=mod((t+(num-1)*tgap),clen/vel);
% 
% if b==0
%     
%     x=clen/2-vel*mod((t+(num-1)*tgap),clen/vel);
%     y= -clen/2;
% elseif b==1
%     y=-clen/2+vel*mod((t+(num-1)*tgap),clen/vel);
%     x= -clen/2;
% elseif b==2
%     x=-clen/2+vel*mod((t+(num-1)*tgap),clen/vel);
%     y= clen/2;
% elseif b==3
%     y=clen/2-vel*mod((t+(num-1)*tgap),clen/vel);
%     x= clen/2;
% else
%     x=clen/2-vel*mod((t+(num-1)*tgap),clen/vel);
%     y= -clen/2;
% end
% y=y+10;
% x=5-x;
% z=-30;

%%%% %%%%%%%%%%%%%%%%%%%%%%%   squ2  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5



%%%% %%%%%%%%%%%%%%%%%%%%%%%   search %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pgap=8;
% vel=0.8;
% clen=20;
% r=10;
% waitt=5;
% w=vel/r;
% phase=6.283/4;
% if t<(clen/vel)
%     x=vel*t;
%     y=-num*pgap+pgap;
% elseif  t<(clen/vel+waitt)
%     x=clen;
%     y=-num*pgap+pgap;
% else
%     tt=t-clen/vel-waitt;
%     x=r*cos(w*tt+num*phase-phase)+clen+r;
%     y=r*sin(w*tt+num*phase-phase)-r-4;
% end
% z=-30-num;
% 
% if num==1
%     z=-35;
% end
% % x=-x;
% % y=-y;
% 
% 
% temp=x;
% x=-y;
% y=temp;

% figure(num)
% plot(x,y,'*','MarkerSize',3*num);
% hold on;
%     
%%%% %%%%%%%%%%%%%%%%%%%%%%%   search %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end















