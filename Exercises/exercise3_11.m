clear;
clc;

M = 100;      
n = 10;
m=12;
alpha = 0.05;     
param_rejections = 0;
bootstrap_rejections = 0;
perm_rejections = 0;


for i = 1:M
    
    X=randn(1,n);
    Y=randn(1,m);
 
    mean_diff=mean(X)-mean(Y);

    [~,p_param] = ttest2(X,Y,'Alpha',alpha);
    param_rejections=param_rejections+(p_param<alpha);

    B = 1000;
    bootstrap_diffs = zeros(B, 1);
    X_boot=bootstrp(B,@mean,X);
    Y_boot=bootstrp(B,@mean,Y);
    bootstrap_diffs = X_boot-Y_boot;
    

    p_bootstrap=mean(abs(bootstrap_diffs)>=abs(mean_diff));
    bootstrap_rejections=bootstrap_rejections+(p_bootstrap < alpha);

    % iii. Έλεγχος τυχαίας αντιμετάθεσης (permutation test)
    perm_diffs = zeros(B, 1);
    combined_sample = [X, Y]; % Συνδυασμός των δύο δειγμάτων
    for b = 1:B
        perm_sample = combined_sample(randperm(m + n)); % Τυχαία αντιμετάθεση
        X_perm = perm_sample(1:n);
        Y_perm = perm_sample(n+1:end);
        perm_diffs(b) = mean(X_perm) - mean(Y_perm);
    end

    % Υπολογισμός p-τιμής για την τυχαία αντιμετάθεση
    p_perm = mean(abs(perm_diffs) >= abs(mean_diff));
    perm_rejections = perm_rejections + (p_perm < alpha);
end

param_reject_rate=param_rejections/M *100;
bootstrap_reject_rate = bootstrap_rejections/M * 100;
perm_reject_rate = perm_rejections/M *100;

fprintf('Ποσοστό απορρίψεων για παραμετρικό έλεγχο: %.2f%%\n', param_reject_rate);
fprintf('Ποσοστό απορρίψεων για bootstrap έλεγχο:  %.2f%%\n', bootstrap_reject_rate);
fprintf('Ποσοστό απορρίψεων για τυχαία αντιμετάθεση: %.2f%%\n', perm_reject_rate);

total_agreements = sum((param_rejections == bootstrap_rejections) & ...
                       (param_rejections == perm_rejections));
agreement_rate = total_agreements / M * 100;
fprintf('Ποσοστό συμφωνίας απορρίψεων και των τριών μεθόδων: %.2f%%\n', agreement_rate);

clear;

M = 100;      
n = 10;
m=12;
alpha = 0.05;     
param_rejections = 0;
bootstrap_rejections = 0;
perm_rejections = 0;


for i = 1:M
    
    X=randn(1,n).^2;
    Y=randn(1,m).^2;
 
    mean_diff=mean(X)-mean(Y);

    [~,p_param]=ttest2(X,Y,'Alpha',alpha);
    param_rejections=param_rejections+(p_param<alpha);

    B = 1000;
    bootstrap_diffs = zeros(B, 1);
    X_boot=bootstrp(B,@mean,X);
    Y_boot=bootstrp(B,@mean,Y);
    bootstrap_diffs = X_boot-Y_boot;
    

    p_bootstrap=mean(abs(bootstrap_diffs)>=abs(mean_diff));
    bootstrap_rejections=bootstrap_rejections+(p_bootstrap < alpha);

    
    perm_diffs = zeros(B, 1);
    combined_sample = [X, Y];
    for b = 1:B
        perm_sample = combined_sample(randperm(m + n)); 
        X_perm = perm_sample(1:n);
        Y_perm = perm_sample(n+1:end);
        perm_diffs(b) = mean(X_perm) - mean(Y_perm);
    end


    p_perm = mean(abs(perm_diffs) >= abs(mean_diff));
    perm_rejections = perm_rejections + (p_perm < alpha);
end

param_reject_rate=param_rejections/M *100;
bootstrap_reject_rate = bootstrap_rejections/M * 100;
perm_reject_rate = perm_rejections/M *100;

fprintf('Ποσοστό απορρίψεων για παραμετρικό έλεγχο: %.2f%%\n', param_reject_rate);
fprintf('Ποσοστό απορρίψεων για bootstrap έλεγχο:  %.2f%%\n', bootstrap_reject_rate);
fprintf('Ποσοστό απορρίψεων για τυχαία αντιμετάθεση: %.2f%%\n', perm_reject_rate);

total_agreements = sum((param_rejections == bootstrap_rejections) & ...
                       (param_rejections == perm_rejections));
agreement_rate = total_agreements / M * 100;
fprintf('Ποσοστό συμφωνίας απορρίψεων και των τριών μεθόδων: %.2f%%\n', agreement_rate);

clear;

M = 100;      
n = 10;
m=12;
alpha = 0.05;     
param_rejections = 0;
bootstrap_rejections = 0;
perm_rejections = 0;


for i = 1:M
    
    X=normrnd(0,1,1,n).^2;
    Y=normrnd(0.2,1,1,m).^2;
 
    mean_diff=mean(X)-mean(Y);

    [~,p_param]=ttest2(X,Y,'Alpha',alpha);
    param_rejections=param_rejections+(p_param<alpha);

    B = 1000;
    bootstrap_diffs = zeros(B, 1);
    X_boot=bootstrp(B,@mean,X);
    Y_boot=bootstrp(B,@mean,Y);
    bootstrap_diffs = X_boot-Y_boot;
    

    p_bootstrap=mean(abs(bootstrap_diffs)>=abs(mean_diff));
    bootstrap_rejections=bootstrap_rejections+(p_bootstrap < alpha);

    
    perm_diffs = zeros(B, 1);
    combined_sample = [X, Y];
    for b = 1:B
        perm_sample = combined_sample(randperm(m + n)); 
        X_perm = perm_sample(1:n);
        Y_perm = perm_sample(n+1:end);
        perm_diffs(b) = mean(X_perm) - mean(Y_perm);
    end


    p_perm = mean(abs(perm_diffs) >= abs(mean_diff));
    perm_rejections = perm_rejections + (p_perm < alpha);
end

param_reject_rate=param_rejections/M *100;
bootstrap_reject_rate = bootstrap_rejections/M * 100;
perm_reject_rate = perm_rejections/M *100;

fprintf('Ποσοστό απορρίψεων για παραμετρικό έλεγχο: %.2f%%\n', param_reject_rate);
fprintf('Ποσοστό απορρίψεων για bootstrap έλεγχο:  %.2f%%\n', bootstrap_reject_rate);
fprintf('Ποσοστό απορρίψεων για τυχαία αντιμετάθεση: %.2f%%\n', perm_reject_rate);

total_agreements = sum((param_rejections == bootstrap_rejections) & ...
                       (param_rejections == perm_rejections));
agreement_rate = total_agreements / M * 100;
fprintf('Ποσοστό συμφωνίας απορρίψεων και των τριών μεθόδων: %.2f%%\n', agreement_rate);

