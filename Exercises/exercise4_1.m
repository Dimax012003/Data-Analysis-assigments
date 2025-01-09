clear;
h2=[60,54,58,60,56];
h1=100;
e1=sqrt(h2/h1);
e_mean=mean(e1);
systematic_error=e_mean-0.76;
random_error=std(e1);
M=1000;
n=5;
h=normrnd(58,2,M,n);
h_statistics=zeros(M,2);
e_statistics=zeros(M,2);
e=zeros(M,n);
for i=1:M
    e(i,:)=sqrt(h(i,:)/h1);
    h_statistics(i,1)=mean(h(i,:));
    h_statistics(i,2)=std(h(i,:));
    e_statistics(i,1)=mean(e(i,:));
    e_statistics(i,2)=std(e(i,:));
end
figure();
hist(h_statistics(:,1));
title('Ιστόγραμμα μέσης τιμής για το h2');

figure();
hist(h_statistics(:,2));
title('Ιστόγραμμα τυπικής απόκλισης για το h2');

figure();
hist(e_statistics(:,1));
title('Ιστόγραμμα μέσης τιμής για το e');

figure();
hist(e_statistics(:,2));
title('Ιστόγραμμα τυπικής απόκλισης για το e');

h_1=[80,100,90,120,95];
h_2=[48,60,50,75,56];

s_h1=std(h_1);
s_h2=std(h_2);
e_total=sqrt(h_2./h_1);
s_e=std(e_total);
[h,p]=ttest(e_total,0.76);
