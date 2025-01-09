data=readmatrix("physical.txt");

y=data(:,1);
X=data(:,2:11);

[B1,fitInfo]=lasso(X,y,'CV',10);
bestlamda=fitInfo.LambdaMinMSE;

[B,fitInfo]=lasso(X,y,'Lambda',bestlamda);
y_lasso=X*B+fitInfo.Intercept;
[R_lasso,adjR_l]=getR(y,y_lasso,length(B(B~=0)));


[~, ~, ~, ~, beta1, PctVar] = plsregress(X, y, 10, 'CV', 10);

% Εξήγηση ποσοστού διακύμανσης στην απόκριση
explainedY = cumsum(PctVar(2, :));

% Επιλογή του αριθμού συνιστωσών που εξηγεί π.χ. 90% της διακύμανσης
threshold = 90; % Ποσοστό
numComponents1 = find(explainedY >= threshold, 1);

[~, ~, ~, ~, beta] = plsregress(X, y, 4);
y_pls=[ones(length(y),1) X]*beta;
[R_pls,adjR_pls]=getR(y,y_pls,5);


[coeff, score, ~, ~, explained] = pca(X);
% Συσσωρευτική εξηγούμενη διακύμανση
cumulativeVariance = cumsum(explained);

% Επιλογή αριθμού συνιστωσών που εξηγούν π.χ. 95% της διακύμανσης
threshold = 95; % Ποσοστό
numComponents = find(cumulativeVariance >= threshold, 1);

X_pcr=score(:,1:numComponents);
X_tpcr=[ones(size(X_pcr,1),1),X_pcr];
b1=regress(y,X_tpcr);
y_pcr=X_tpcr*b1;
[R_pcr,adjR_pcr]=getR(y,y_pcr,numComponents);



% Ridge Regression
lambdas=[1,0.1,0.01,0.001,0.0001,0.5,0.2,0.02];
mdl=fitrlinear(X,y,'Learner','leastsquares','Lambda',lambdas,'KFold',5);

cvMSE = kfoldLoss(mdl);

% Βέλτιστη τιμή λ
[~, idx] = min(cvMSE); % Εύρεση του index με το μικρότερο MSE
bestlambda = lambdas(idx);

mdl=fitrlinear(X,y,'Learner','leastsquares','Lambda',bestlambda);
y_rr=predict(mdl,X);
[R_rr,adjR_rr]=getR(y,y_rr,10);
b_rr=mdl.Beta;



function [R,adjR2]=getR(y,y_hat,k)
    n=length(y);
    R=1-(sum((y-y_hat).^(2)))/(sum((y-mean(y)).^(2)));
    adjR2=1-((n-1)/(n-(k+1)))*(sum((y-y_hat).^(2)))/(sum((y-mean(y)).^(2)));
end