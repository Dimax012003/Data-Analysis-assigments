data=readmatrix('lightdair.txt');

x=data(:,1);
y=zeros(length(x),1);
for i =1:length(x)
    y(i)=data(i,2)+299000;
end
M=1000;
b0=zeros(1,M);
b1=zeros(1,M);
for i=1:M
    d=unidrnd(100,100,1);
    xj=x(d);
    yj=y(d);
    a=0;
    b=0;
    xj_bar=mean(xj);
    yj_bar=mean(yj);
    for j=1:length(data(:,1))
        a=a+(xj(j)-xj_bar)*(yj(j)-yj_bar);
        b=b+(xj(j)-xj_bar)^2;
    end
    b1(i)=a/b;
    b0(i)=(1/length(xj))*(sum(yj)-b1(i)*sum(xj));
end
b0=sort(b0);
b1=sort(b1);
disp([num2str(b0(25)),' ',num2str(b0(975))]);
disp([num2str(b1(25)),' ',num2str(b1(975))]);