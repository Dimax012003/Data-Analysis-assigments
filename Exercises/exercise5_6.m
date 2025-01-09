x=[2,3,8,16,32,48,64,80];
y=[98.2,91.7,81.3,64.0,36.4,32.6,17.1,11.3];
figure();
scatter(x,y);
hold on;
x_bar=mean(x);
y_bar=mean(y);
n=length(x);

a=0;
b=0;
for i=1:length(x)
    a=a+(x(i)-x_bar)*(y(i)-y_bar);
    b=b+(x(i)-x_bar)^2;
end
b1=a/b;
b0=(1/length(x))*(sum(y)-b1*sum(x));

y_estimated=b0+b1*x;
plot(x,y_estimated);
grid on;

e=y-y_estimated;
se=sqrt(1/(n-2)*sum((y-y_estimated).^(2)));
e_star=e/se;
figure();
plot(1:4:80,2*ones(1,20));
hold on;
plot(1:4:80,-2*ones(1,20));
hold on;
scatter(x,e_star);

ylim([-3 3]);
grid on;

y1=b0+b1*25;
disp(y1);



