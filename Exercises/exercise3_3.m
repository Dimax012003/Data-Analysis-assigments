M=1000;
count1=0;
count2=0;
m=15;
for i=1:M
    [t1,m1]=calculation(5);
    if(abs(m1-m)<t1)
        count1=count1+1;
    end
end

for i=1:M
    [t1,m1]=calculation(100);
    if(abs(m1-m)<t1)
        count2=count2+1;
    end
end

disp(['Ποσοστό δειγμάτων εντός διαστήματος εμπιστοσύνης για n=5 , p1=',num2str(count1/M)]);
disp(['Ποσοστό δειγμάτων εντός διαστήματος εμπιστοσύνης για n=100 , p1=',num2str(count2/M)]);

function [t,m]=calculation(n)
    X = exprnd(15,1,n); 
    m = (1/n)*sum(X);
    s=sqrt((1/(n-1))*(sum(X.^(2))-n*m*m));
    t=tinv(0.975,n-1)*(s/sqrt(n));
end