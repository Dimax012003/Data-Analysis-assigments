n=10;
x=normrnd(0,1,1,n);
y=exp(x);
[s1,s2]=bootstrap(x,1);
[s3,s4]=bootstrap(y,2);


function [se,s]=bootstrap(x,i)
    B=1000;
    b=bootstrp(B,@mean,x);
    figure(i);
    hist(b);
    xline(mean(x),'--y');
    xline(mean(b),'--r');
    xlabel('Μέσες τιμές απο δείγματα bootstrap ');
    ylabel('Σύχνοτητα μέσης τιμής');
    grid on;

    se=std(b);
    s=std(x)/sqrt(10);

    disp(abs(se-s));
    disp(mean(b));
end