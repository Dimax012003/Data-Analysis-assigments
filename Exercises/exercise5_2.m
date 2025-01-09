
p1=calculation([0,0],[1 0;0 1],20,1000,1000,1);
p2=calculation([0,0],[1 0;0 1],20,1000,1000,2);

function p=calculation(mu,S,n,M,L,power)
    p=0;
    for i=1:M
        data=mvnrnd(mu,S,n);
        x=data(:,1).^(power);
        y=data(:,2).^(power);
  
        t_0=tget(x,y,n);
        tl=[];
        for j=1:L
            random=randperm(n);
            x_r=x(random);
            tl=[tl tget(x_r,y,n)];
        end
        t_sorted=sort(tl);
        if (t_0<t_sorted(25) || t_0>t_sorted(975))
            p=p+1;
        end
    end

end
function t=tget(x,y,n)
    s_xy=sum(x.*y)-n*mean(x)*mean(y);
    s_x=sum(x.^(2))-n*mean(x);
    s_y=sum(y.^(2))-n*mean(y);

    r=(s_xy)/(sqrt(s_x*s_y));
    t=r*sqrt((n-2)/(1-r^2));
end