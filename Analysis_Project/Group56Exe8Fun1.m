
% Dimitris Aximiotis 10622
% Nikos Toulkeridis  10718

function [b,y_hat]=Group56Exe8Fun1(y,table)
    n=length(table);

    X=zeros(length(table{1}),n+1);
    for i=1:n+1
        if i==1
            X(:,i)=ones(length(table{i}),1);
        else
            X(:,i)=table{i-1};
        end
    end
    disp(X);
    b=X'*X \ X'*y;
    y_hat=X*b;
end