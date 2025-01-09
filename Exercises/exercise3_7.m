

M=100;
m=[];
n=100;
for i=1:M
    m=[m mean(normrnd(0,1,n,1))];
end
[h,p,c]=ttest(m,mean(m));
disp(['Παραμετρικό διάστημα εμπιστοσύνης:','[',num2str(c(1)),',',num2str(c(2)),']']);
b=bootstrp(100,@mean,m);
y=sort(b);
disp(['Διάστημα μέσω ποσοστιαίων μεθόδων boostrap:','[',num2str(y(3)),',',num2str(y(98)),']']);
figure(1);
hist(m,8);
xline(c(1),'--r');
xline(c(2),'--r');

xline(y(3),'--b');
xline(y(98),'--b');
title('Ιστόγραμμα κανονικής κατανομής X');
clear;

M=100;
m=[];
n=10;

for i=1:M
    m=[m mean(normrnd(0,1,n,1).^2)];
end
[h,p,c]=ttest(m,mean(m));
disp(['Παραμετρικό διάστημα εμπιστοσύνης:','[',num2str(c(1)),',',num2str(c(2)),']']);
b=bootstrp(100,@mean,m);
y=sort(b);
disp(['Διάστημα μέσω ποσοστιαίων μεθόδων boostrap:','[',num2str(y(3)),',',num2str(y(98)),']']);
figure(2);
hist(m,8);
xline(c(1),'--r');
xline(c(2),'--r');

xline(y(3),'--b');
xline(y(98),'--b');
title('Iστόγραμμα κατανομής X^2');