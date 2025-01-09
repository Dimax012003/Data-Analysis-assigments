clear;
M=1000;
s_i=0.071;
s_v=0.71;
s_f=0.017;
m_i=1.21;
m_v=77.78;
m_f=0.283;
i=normrnd(m_i,s_i,1,M);
v=normrnd(m_v,s_v,1,M);
f=normrnd(m_f,s_f,1,M);
p=zeros(1,M);
s_p_theorytical=sqrt((m_v*cos(m_f)*s_i)^2+(m_i*cos(m_f)*s_v)^2+(m_v*m_i*sin(m_f)*s_f)^2);
m_p_theorytical=m_v*m_i*cos(m_f);
for j=1:M
    p(j)=v(j)*i(j)*cos(f(j));
end
m_p=mean(i)*mean(v)*mean(cos(f));
s_p=std(p);


clear;


M=1000;
s_i=0.071;
s_v=0.71;
s_f=0.017;
m_i=1.21;
m_v=77.78;
m_f=0.283;
m=[m_v,m_i,m_f];
s=[s_v,s_i,s_f];

rho_vf=0.5;


S = [s_v^2,0,rho_vf * s_v * s_f;
     0,s_i^2,0;
  rho_vf*s_v*s_f,0,s_f^2];
data=mvnrnd(m,S,M);
i=data(:,1);
v=data(:,2);
f=data(:,3);

syms V I F
P=V*I*cos(F);

df=[diff(P,V),diff(P,I),diff(P,F)];

vals={V,I,F};
mean_vals={m_v,m_i,m_f};
df_vals=subs(df,vals,mean_vals);


s_y_2=0;
for j=1:3
    s_y_2=s_y_2+(df_vals(j)*s(j))^2;
end

s_y_2_1=0;
for j=1:2
    for k=j+1:3
        s_y_2_1=s_y_2_1+df_vals(j)*df_vals(k)*S(j, k);
    end
end


s_y_2_total=s_y_2+2*s_y_2_1;
s_y=sqrt(double(s_y_2_total));

p=v.*i.*cos(f);
sd=std(p);

disp('Η τιμή του s_y είναι:')
disp(s_y)
disp('Η τιμή του της αποκλισης του δειγματος:')
disp(sd);
