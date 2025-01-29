function [x,y,z] =trjufc(timestamp,num,flagg,stat,carstate,trj_flag,form_flag,avo_flag)
point_time=0;
zstart=-0.5;
persistent time_start ts td x0 y0;

persistent n;

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



if flagg<=1 || (ts+td< point_time)
    td=timestamp-ts;
    t=ts;
else
    ts=timestamp-td;
    t=ts;
    n=n+1;
    
end

if ts+td< point_time
    x0=stat(12*num-11);
    y0=stat(12*num-10);
    x=x0;
    y=y0;
    z=zstart;
elseif flagg==1
    x=x0;
    y=y0;
    z=-1;
else 
    x0=stat(12*num-11);
    y0=stat(12*num-10);
    x=stat(12*num-11+120);
    y=stat(12*num-10+120);
    z=-1;
end



end















