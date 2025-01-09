data=readmatrix('lightdair.txt');

x=data(:,1);
y=zeros(length(x),1);
for i =1:length(x)
    y(i)=data(i,2)+299000;
end

figure(1);
scatter(x,y);
xlabel('Μετρήσεις πυκνότητας αέρα');
ylabel('Ταχύτητα φωτός');
hold on;

x_bar=mean(x);
y_bar=mean(y);
n=length(x);

%υπολογισμός εκτίμησης b1
a=0;
b=0;
for i=1:length(data(:,1))
    a=a+(x(i)-x_bar)*(y(i)-y_bar);
    b=b+(x(i)-x_bar)^2;
end
b1=a/b;

%υπολογισμός εκτίμησης b0
b0=(1/length(x))*(sum(y)-b1*sum(x));

y_estimated=b0+b1*x;
%Υπολογισμός διαστήματος εμπιστοσύνης για το b1
se=sqrt(1/(n-2)*sum((y-y_estimated).^(2)));
Sxx=sum((x-x_bar).^(2));
t=tinv(0.975,n-2);

b1_low =b1-t*(se/sqrt(Sxx));
b1_high=b1+t*(se/sqrt(Sxx));

%Υπολογισμός διαστήματος εμπιστοσύνης για το b0
b0_low =b0-t*(se*sqrt((1/n)+(x_bar^2/Sxx)));
b0_high=b0+t*(se*sqrt((1/n)+(x_bar^2/Sxx)));

plot(x,y_estimated);
hold on;


%y_average
y_low=zeros(1,n);
y_high=zeros(1,n);

for i=1:n
    y_low(i) =y_estimated(i)-t*(se*sqrt((1/n)+((x(i)-x_bar)^2/Sxx)));
    y_high(i)=y_estimated(i)+t*(se*sqrt((1/n)+((x(i)-x_bar)^2/Sxx)));
    %% και για μια παρατηρηση
    
end

scatter(x,y_low);
scatter(x,y_high);
grid on;
legend('Διάγραμμα διασποράς','Ευθεία γραμμικής παλινδρόμησης','Κατω ακρο διαστηματος','Ανω άκρο διαστήματος');

%εκτίμηση δεδομένου x=1.29
y_1=b0+b1*1.29;
y1_low =y_1-t*(se*sqrt((1/n)+((1.29-x_bar)^2/Sxx)));
y1_high=y_1+t*(se*sqrt((1/n)+((1.29-x_bar)^2/Sxx)));

B0=299792;
B1=-67.2171;

t0=(B0-b0)/(se*sqrt((1/n)+(x_bar^2/Sxx)));
pt0=2*(1-tcdf(abs(t0),n-2));
t1=(B1-b1)*sqrt(Sxx)/se;
pt1=2*(1-tcdf(abs(t1),n-2));

count=0;
for i=1:n
    if ((B0+B1*x(i))<y_low(i) || (B0+B1*x(i))>y_high(i))
        count=count+1;
    end
end