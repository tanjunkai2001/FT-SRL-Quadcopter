function y = satgd( u,a )
temp = norm(u,Inf);
    if  temp<=a
        y = u;
    else
        y= a*u/temp;
    end



