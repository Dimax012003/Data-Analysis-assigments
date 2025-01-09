clear;
n=50;
p=5;

b_0=[0,0.2,0,-3,0]';
for i=1:50
    X(i,:)=exprnd(5+5*rand(1,1),5,1);
end
e=5*randn(50,1);
y=X*b_0+e;

%linear regression
[b,y_pred1]=model(X,y,5);
[R1,adjR1]=getR(y,y_pred1,5);

%stepwise regression
mdl1=stepwiselm(X,y);
y_pred2=mdl1.predict(X);
[R2,adjR2]=getR(y,y_pred2,mdl1.NumEstimatedCoefficients);

[coeff, score, ~, ~, explained] = pca(X);
% Συσσωρευτική εξηγούμενη διακύμανση
cumulativeVariance = cumsum(explained);

% Επιλογή αριθμού συνιστωσών που εξηγούν π.χ. 95% της διακύμανσης
threshold = 95; % Ποσοστό
numComponents = find(cumulativeVariance >= threshold, 1);

X_pcr=score(:,1:numComponents);
X_tpcr=[ones(size(X_pcr,1),1),X_pcr];
b1=regress(y,X_tpcr);
y_pred3=X_tpcr*b1;
[R3,adjR3]=getR(y,y_pred3,numComponents);

[B1,fitInfo]=lasso(X,y,'CV',10);
bestLambda = fitInfo.LambdaMinMSE;

[B,fitInfo]=lasso(X,y,'Lambda',bestLambda);
y_pred4=X*B+fitInfo.Intercept;
[R4,adjR4]=getR(y,y_pred4,length(B(B~=0)));

% Αριθμός μέγιστων συνιστωσών προς δοκιμή
maxComponents = 5;

% Cross-validation για PLS
[~, ~, ~, ~, beta, PctVar] = plsregress(X, y, maxComponents, 'CV', 10);

% Εξήγηση ποσοστού διακύμανσης στην απόκριση
explainedY = cumsum(PctVar(2, :));

% Επιλογή του αριθμού συνιστωσών που εξηγεί π.χ. 90% της διακύμανσης
threshold = 90; % Ποσοστό
numComponents1 = find(explainedY >= threshold, 1);

[~, ~, ~, ~, beta] = plsregress(X, y, 4);
y_pred5=[ones(length(y),1) X]*beta;
[R5,adjR5]=getR(y,y_pred5,5);

% Ridge Regression
lambdas=[1,0.1,0.01,0.001,0.0001,0.5,0.2,0.02];
mdl=fitrlinear(X,y,'Learner','leastsquares','Lambda',lambdas,'KFold',5);

cvMSE = kfoldLoss(mdl);

% Βέλτιστη τιμή λ
[~, idx] = min(cvMSE); % Εύρεση του index με το μικρότερο MSE
bestlambda = lambdas(idx);

mdl=fitrlinear(X,y,'Learner','leastsquares','Lambda',bestLambda);
y_pred6=predict(mdl,X);
[R6,adjR6]=getR(y,y_pred6,5);
b_rr=mdl.Beta;


figure();
title('linear model');
plot(1:length(y),y,1:length(y),y_pred1);
grid on;
legend('y','y_hat');

figure();
title('stepwise');
plot(1:length(y),y,1:length(y),y_pred2);
grid on;
legend('y','y_hat');


figure();
title('PCR');
plot(1:length(y),y,1:length(y),y_pred3);
grid on;
legend('y','y_hat');

figure();
title('Lasso');
plot(1:length(y),y,1:length(y),y_pred4);
grid on;
legend('y','y_hat');

figure();
title('PLS');
plot(1:length(y),y,1:length(y),y_pred5);
grid on;
legend('y','y_hat');

figure();
plot(1:length(y),y,1:length(y),y_pred6);
legend('y','y_hat');
grid on;

e_star1=error(y,y_pred1,5);
e_star2=error(y,y_pred2,mdl1.NumEstimatedCoefficients);
e_star3=error(y,y_pred3,numComponents);
e_star4=error(y,y_pred4,length(B(B~=0)));
e_star5=error(y,y_pred5,5);
e_star6=error(y,y_pred6,5);

figure();
scatter(1:length(y),e_star1);
title('error plot for linear model');
grid on;

figure();
scatter(1:length(y),e_star2);
title('error plot for stepwise model');
grid on;

figure();
scatter(1:length(y),e_star3);
title('error plot for pcr model');
grid on;

figure();
scatter(1:length(y),e_star4);
title('error plot for lasso model');
grid on;

figure();
scatter(1:length(y),e_star5);
title('error plot for pls model');
grid on;

figure();
scatter(1:length(y),e_star6);
title('error plot for RR model');
grid on;

function [R,adjR2]=getR(y,y_hat,k)
    n=length(y);
    R=1-(sum((y-y_hat).^(2)))/(sum((y-mean(y)).^(2)));
    adjR2=1-((n-1)/(n-(k+1)))*(sum((y-y_hat).^(2)))/(sum((y-mean(y)).^(2)));
end

function [b,y_estimated]=model(x,y,n)
    t=ones(length(x),1);
    X=zeros(length(x),n);
    X(:,1)=t;
    for i=2:n+1
        X(:,i)=x(:,i-1);
    end
    b=inv(X'*X)*X'*y;
    y_estimated=X*b;
end

function e_star=error(y,y_hat,k)
    e=y-y_hat;
    n=length(y);
    se=sqrt(1/(n-(k+1))*sum((y-y_hat).^(2)));
    e_star=e/(se);
end