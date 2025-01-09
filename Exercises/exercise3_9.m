
M = 100;     
n = 10;      
m = 12;     

X_samples = randn(M, n);
Y_samples = randn(M, m);

param_CI_counts = 0;
bootstrap_CI_counts = 0;


for i = 1:M

    mean_X = mean(X_samples(i, :));
    mean_Y = mean(Y_samples(i, :));
    diff_means = mean_X - mean_Y;

    pooled_std = sqrt(var(X_samples(i, :)) / n + var(Y_samples(i, :)) / m);
    param_CI = [diff_means - 1.96 * pooled_std, diff_means + 1.96 * pooled_std];

    B = 1000;
    boot_diffs = zeros(B, 1);
    for b = 1:B
        boot_X = randsample(X_samples(i, :), n, true);
        boot_Y = randsample(Y_samples(i, :), m, true);
        boot_diffs(b) = mean(boot_X) - mean(boot_Y);
    end
    bootstrap_CI = prctile(boot_diffs, [2.5, 97.5]);

    param_CI_counts = param_CI_counts + (param_CI(1) > 0 || param_CI(2) < 0);
    bootstrap_CI_counts = bootstrap_CI_counts + (bootstrap_CI(1) > 0 || bootstrap_CI(2) < 0);
end

param_diff_percent = param_CI_counts / M * 100;
bootstrap_diff_percent = bootstrap_CI_counts / M * 100;

fprintf('Μέρος α:\n');
fprintf('Παραμετρικό CI ποσοστό διαφοράς: %.2f%%\n', param_diff_percent);
fprintf('Bootstrap CI ποσοστό διαφοράς: %.2f%%\n', bootstrap_diff_percent);




Y_samples_transformed = X_samples .^ 2;


param_CI_counts = 0;
bootstrap_CI_counts = 0;

for i = 1:M
   
    mean_X = mean(X_samples(i, :));
    mean_Y = mean(Y_samples_transformed(i, :));
    diff_means = mean_X - mean_Y;


    pooled_std = sqrt(var(X_samples(i, :)) / n + var(Y_samples_transformed(i, :)) / n);
    param_CI = [diff_means - 1.96 * pooled_std, diff_means + 1.96 * pooled_std];


    boot_diffs = zeros(B, 1);
    for b = 1:B
        boot_X = randsample(X_samples(i, :), n, true);
        boot_Y = randsample(Y_samples_transformed(i, :), n, true);
        boot_diffs(b) = mean(boot_X) - mean(boot_Y);
    end
    bootstrap_CI = prctile(boot_diffs, [2.5, 97.5]);

  
    param_CI_counts = param_CI_counts + (param_CI(1) > 0 || param_CI(2) < 0);
    bootstrap_CI_counts = bootstrap_CI_counts + (bootstrap_CI(1) > 0 || bootstrap_CI(2) < 0);
end

param_diff_percent = param_CI_counts / M * 100;
bootstrap_diff_percent = bootstrap_CI_counts / M * 100;

fprintf('\nΜέρος β:\n');
fprintf('Παραμετρικό CI ποσοστό διαφοράς (με Y = X^2): %.2f%%\n', param_diff_percent);
fprintf('Bootstrap CI ποσοστό διαφοράς (με Y = X^2): %.2f%%\n', bootstrap_diff_percent);


Y_samples_shifted = 0.2 + randn(M, m);


param_CI_counts = 0;
bootstrap_CI_counts = 0;

for i = 1:M
    mean_X = mean(X_samples(i, :));
    mean_Y = mean(Y_samples_shifted(i, :));
    diff_means = mean_X - mean_Y;

   
    pooled_std = sqrt(var(X_samples(i, :)) / n + var(Y_samples_shifted(i, :)) / m);
    param_CI = [diff_means - 1.96 * pooled_std, diff_means + 1.96 * pooled_std];

    boot_diffs = zeros(B, 1);
    for b = 1:B
        boot_X = randsample(X_samples(i, :), n, true);
        boot_Y = randsample(Y_samples_shifted(i, :), m, true);
        boot_diffs(b) = mean(boot_X) - mean(boot_Y);
    end
    bootstrap_CI = prctile(boot_diffs, [2.5, 97.5]);

    param_CI_counts = param_CI_counts + (param_CI(1) > 0 || param_CI(2) < 0);
    bootstrap_CI_counts = bootstrap_CI_counts + (bootstrap_CI(1) > 0 || bootstrap_CI(2) < 0);
end


param_diff_percent = param_CI_counts / M * 100;
bootstrap_diff_percent = bootstrap_CI_counts / M * 100;

fprintf('\nΜέρος γ:\n');
fprintf('Παραμετρικό CI ποσοστό διαφοράς (με Y ~ N(0.2,1)): %.2f%%\n', param_diff_percent);
fprintf('Bootstrap CI ποσοστό διαφοράς (με Y ~ N(0.2,1)): %.2f%%\n', bootstrap_diff_percent);
