mu=[0,0];
rho=0;

S=[1 rho*1;rho*1 1];
M=1000;
n=20;


[parametric_rejections,percentage] = calculation(mu,S,n,M,rho,1);
disp(['Ποσοστό δειγμάτων που έχουν την τιμή ρ:',num2str((1-percentage/M)*100)]);
disp(['Ποσοστό απόρριψης μηδενικής υπόθεσης  :',num2str((parametric_rejections/M)*100)]);

rho=0.5;

[parametric_rejections1,percentage1] = calculation(mu,S,n,M,rho,1);
disp(['Ποσοστό δειγμάτων που έχουν την τιμή ρ:',num2str((1-percentage1/M)*100)]);
disp(['Ποσοστό απόρριψης μηδενικής υπόθεσης  :',num2str((parametric_rejections1/M)*100)]);

n=200;

[parametric_rejections,percentage] = calculation(mu,S,n,M,rho,1);
disp(['Ποσοστό δειγμάτων που έχουν την τιμή ρ:',num2str((1-percentage/M)*100)]);
disp(['Ποσοστό απόρριψης μηδενικής υπόθεσης  :',num2str((parametric_rejections/M)*100)]);

rho=0.5;

[parametric_rejections1,percentage1] = calculation(mu,S,n,M,rho,1);
disp(['Ποσοστό δειγμάτων που έχουν την τιμή ρ:',num2str((1-percentage1/M)*100)]);
disp(['Ποσοστό απόρριψης μηδενικής υπόθεσης  :',num2str((parametric_rejections1/M)*100)]);

n=20;

[parametric_rejections,percentage] = calculation(mu,S,n,M,rho,2);
disp(['Ποσοστό δειγμάτων που έχουν την τιμή ρ:',num2str((1-percentage/M)*100)]);
disp(['Ποσοστό απόρριψης μηδενικής υπόθεσης  :',num2str((parametric_rejections/M)*100)]);

rho=0.5;

[parametric_rejections1,percentage1] = calculation(mu,S,n,M,rho,2);
disp(['Ποσοστό δειγμάτων που έχουν την τιμή ρ:',num2str((1-percentage1/M)*100)]);
disp(['Ποσοστό απόρριψης μηδενικής υπόθεσης  :',num2str((parametric_rejections1/M)*100)]);


n=200;

[parametric_rejections,percentage] = calculation(mu,S,n,M,rho,2);
disp(['Ποσοστό δειγμάτων που έχουν την τιμή ρ:',num2str((1-percentage/M)*100)]);
disp(['Ποσοστό απόρριψης μηδενικής υπόθεσης  :',num2str((parametric_rejections/M)*100)]);

rho=0.5;

[parametric_rejections1,percentage1] = calculation(mu,S,n,M,rho,2);
disp(['Ποσοστό δειγμάτων που έχουν την τιμή ρ:',num2str((1-percentage1/M)*100)]);
disp(['Ποσοστό απόρριψης μηδενικής υπόθεσης  :',num2str((parametric_rejections1/M)*100)]);



function [p_t,p]=calculation(mu,S,n,M,rho,power)
    r=zeros(1,M);
    parray=[];
    p=0;
    rl_array=[];
    ru_array=[];    
    p_t=0;
    for i=1:M
        data = mvnrnd(mu,S,n);
        x=data(:,1).^(power);
        y=data(:,2).^(power);
    
        s_xy=sum(x.*y)-n*mean(x)*mean(y);
        s_x=sum(x.^(2))-n*mean(x);
        s_y=sum(y.^(2))-n*mean(y);

        r=(s_xy)/(sqrt(s_x*s_y));
    
        w=0.5*log((1+r)/(1-r));
        z1=w-norminv(0.975)*(sqrt(1/(n-3)));
        z2=w+norminv(0.975)*(sqrt(1/(n-3)));
    
        rl=tanh(z1);
        ru=tanh(z2);
        rl_array=[rl_array real(rl)];
        ru_array=[ru_array real(ru)];
        if(rho<rl || ru<rho)
            p=p+1;
        end
        t=r*sqrt((n-2)/(1-r^2));
        pt=2*(1-tcdf(abs(t),n-2));
        parray=[parray pt];
        p_t=p_t+(pt<0.05);
    end
    figure(1);
    histogram(rl_array);
    figure(2);
    histogram(ru_array);
end