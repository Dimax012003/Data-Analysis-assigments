lambda=[0.1,0.5,0.2,0.8,0.25];
m1=calculation(1000,1000,lambda(1));
m2=calculation(10000,100,lambda(2));
m3=calculation(40,2000,lambda(3));
m4=calculation(4000,10,lambda(4));
m5=calculation(5000,500,lambda(5));
m=[m1,m2,m3,m4,m5];
for i=1:5
    disp(['Απόκλιση από μέση τιμή ',num2str(i),'ου πειράματος κατά απόλυτη τιμή: ',num2str(abs(m(i)-1/lambda(i)))]);
end

function m=calculation(M,n,lambda)
    mi = [];
    for i = 1:M
        X = exprnd(1/lambda,1,n); 
        mi = [mi sum(X)/n];
    end
    m = sum(mi)/M;
    figure;
    histogram(mi,10);
    title(['λ=',num2str(lambda),', ','M=',num2str(M),', ','n=',num2str(n)]);
    xlabel("Μέση τιμή");
    ylabel("Δείγματα");
    grid on;
    hold on

end