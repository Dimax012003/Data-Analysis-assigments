M=100;
n=10;
m=12;
x=normrnd(0,1,M,n);
y=normrnd(0,1,M,m);
h_parametric=zeros(1,M);
h_bootstrap=zeros(1,M);
x_bar=zeros(M,n);
y_bar=zeros(M,n);
B=100;
for i=1:M
    %%παραμετρικός έλεγχος
    s_x=std(x(i,:))^2/n;
    s_y=std(y(i,:))^2/m;
    df=(s_x+s_y)^2/((s_x^2/(n-1))+(+s_y^2/(m-1)));
    t=(mean(x(i,:))-mean(y(i,:)))/(sqrt(s_x+s_y));
    t_c=tinv(0.95,df);
    if(abs(t)>t_c)
        h_parametric(i)=1;
    else 
        h_parametric(i)=0;
    end
    
    %%έλεγχος boostrap
    z=(sum(x(i,:))+sum(y(i,:)))/(n+m);
    for j=1:n
        x_bar(i,j)=x(i,j)-mean(x(i,:))+z;
    end
    for k=1:n
        y_bar(i,k)=y(i,k)-mean(y(i,:))+z;
    end
    x_sample=bootstrp(B,@mean,x_bar(i,:));
    y_sample=bootstrp(B,@mean,y_bar(i,:));
    common_sample=zeros(1,B);
    common_sample=x_sample-y_sample;
    common_sample=sort(common_sample);
    if((mean(x(i,:))-mean(y(i,:)))>common_sample(3) && (mean(x(i,:))-mean(y(i,:)))<common_sample(98))
        h_bootstrap(i)=0;
    else 
        h_bootstrap(i)=1;
    end

end
disp(['Ποσοστό απορρίψεων με παραμετρικό έλεγχο :',num2str(sum(h_parametric)/M)]);
disp(['Ποσοστό απορρίψεων με bootstrap έλεγχο :',num2str(sum(h_bootstrap)/M)]);
