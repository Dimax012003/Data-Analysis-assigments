% Αρχικοποίηση παραμέτρων
M = 100;     % Αριθμός δειγμάτων bootstrap
n = 10;      % Μέγεθος δείγματος
alpha = 0.05; % Επίπεδο σημαντικότητας

% Δημιουργία δειγμάτων από X ~ N(0,1)
X_samples = randn(M, n);

% Αρχικοποίηση για την αποθήκευση των αποτελεσμάτων
param_rejections_H0_0 = 0;      % Παραμετρικές απορρίψεις για H0: μ = 0
param_rejections_H0_05 = 0;     % Παραμετρικές απορρίψεις για H0: μ = 0.5
bootstrap_rejections_H0_0 = 0;  % Bootstrap απορρίψεις για H0: μ = 0
bootstrap_rejections_H0_05 = 0; % Bootstrap απορρίψεις για H0: μ = 0.5

% (α) Έλεγχος υποθέσεων για κάθε δείγμα
for i = 1:M
    % Δείγμα i
    sample = X_samples(i, :);
    sample_mean = mean(sample);
    sample_std = std(sample);

    % i. Παραμετρικός έλεγχος
    % Έλεγχος H0: μ = 0
    t_stat_0 = (sample_mean - 0) / (sample_std / sqrt(n));
    p_value_0 = 2 * (1 - tcdf(abs(t_stat_0), n - 1));
    param_rejections_H0_0 = param_rejections_H0_0 + (p_value_0 < alpha);

    % Έλεγχος H0: μ = 0.5
    t_stat_05 = (sample_mean - 0.5) / (sample_std / sqrt(n));
    p_value_05 = 2 * (1 - tcdf(abs(t_stat_05), n - 1));
    param_rejections_H0_05 = param_rejections_H0_05 + (p_value_05 < alpha);

    % ii. Bootstrap έλεγχος
    % Κεντράρισμα του δείγματος σύμφωνα με τη μηδενική υπόθεση για H0: μ = 0
    centered_sample_0 = sample - sample_mean + 0;
    % Κεντράρισμα του δείγματος σύμφωνα με τη μηδενική υπόθεση για H0: μ = 0.5
    centered_sample_05 = sample - sample_mean + 0.5;

    % Δημιουργία bootstrap δειγμάτων και υπολογισμός του μέσου για κάθε bootstrap δείγμα
    B = 1000; % Αριθμός bootstrap επαναλήψεων
    bootstrap_means_0 = zeros(B, 1);
    bootstrap_means_05 = zeros(B, 1);

    for b = 1:B
        % Δειγματοληψία με επανατοποθέτηση από το κεντραρισμένο δείγμα
        boot_sample_0 = randsample(centered_sample_0, n, true);
        boot_sample_05 = randsample(centered_sample_05, n, true);
        bootstrap_means_0(b) = mean(boot_sample_0);
        bootstrap_means_05(b) = mean(boot_sample_05);
    end

    % Υπολογισμός στατιστικού ελέγχου στο αρχικό δείγμα
    t_stat_orig_0 = sample_mean - 0;
    t_stat_orig_05 = sample_mean - 0.5;

    % Υπολογισμός p-τιμής bootstrap ως ποσοστό υπερβάσεων
    p_value_boot_0 = mean(abs(bootstrap_means_0) >= abs(t_stat_orig_0));
    p_value_boot_05 = mean(abs(bootstrap_means_05) >= abs(t_stat_orig_05));

    % Αποδοχή ή απόρριψη βάσει του p-value bootstrap
    bootstrap_rejections_H0_0 = bootstrap_rejections_H0_0 + (p_value_boot_0 < alpha);
    bootstrap_rejections_H0_05 = bootstrap_rejections_H0_05 + (p_value_boot_05 < alpha);
end

% Υπολογισμός ποσοστών απόρριψης για τις παραμετρικές και bootstrap δοκιμές
param_reject_rate_H0_0 = param_rejections_H0_0 / M * 100;
param_reject_rate_H0_05 = param_rejections_H0_05 / M * 100;
bootstrap_reject_rate_H0_0 = bootstrap_rejections_H0_0 / M * 100;
bootstrap_reject_rate_H0_05 = bootstrap_rejections_H0_05 / M * 100;

fprintf('Μέρος α:\n');
fprintf('Παραμετρικός έλεγχος - Ποσοστό απορρίψεων για H0: μ = 0: %.2f%%\n', param_reject_rate_H0_0);
fprintf('Bootstrap έλεγχος - Ποσοστό απορρίψεων για H0: μ = 0: %.2f%%\n', bootstrap_reject_rate_H0_0);
fprintf('Παραμετρικός έλεγχος - Ποσοστό απορρίψεων για H0: μ = 0.5: %.2f%%\n', param_reject_rate_H0_05);
fprintf('Bootstrap έλεγχος - Ποσοστό απορρίψεων για H0: μ = 0.5: %.2f%%\n', bootstrap_reject_rate_H0_05);

%% (β) Θεωρείστε τον μετασχηματισμό Y = X^2 και επαναλάβετε

% Εφαρμογή μετασχηματισμού Y = X^2
Y_samples = X_samples .^ 2;

% Μηδενισμός των μετρητών
param_rejections_H0_1 = 0;
param_rejections_H0_2 = 0;
bootstrap_rejections_H0_1 = 0;
bootstrap_rejections_H0_2 = 0;

for i = 1:M
    sample = Y_samples(i, :);
    sample_mean = mean(sample);
    sample_std = std(sample);

    % i. Παραμετρικός έλεγχος
    % Έλεγχος H0: μ = 1
    t_stat_1 = (sample_mean - 1) / (sample_std / sqrt(n));
    p_value_1 = 2 * (1 - tcdf(abs(t_stat_1), n - 1));
    param_rejections_H0_1 = param_rejections_H0_1 + (p_value_1 < alpha);

    % Έλεγχος H0: μ = 2
    t_stat_2 = (sample_mean - 2) / (sample_std / sqrt(n));
    p_value_2 = 2 * (1 - tcdf(abs(t_stat_2), n - 1));
    param_rejections_H0_2 = param_rejections_H0_2 + (p_value_2 < alpha);

    % ii. Bootstrap έλεγχος
    % Κεντράρισμα για H0: μ = 1 και H0: μ = 2
    centered_sample_1 = sample - sample_mean + 1;
    centered_sample_2 = sample - sample_mean + 2;

    bootstrap_means_1 = zeros(B, 1);
    bootstrap_means_2 = zeros(B, 1);

    for b = 1:B
        boot_sample_1 = randsample(centered_sample_1, n, true);
        boot_sample_2 = randsample(centered_sample_2, n, true);
        bootstrap_means_1(b) = mean(boot_sample_1);
        bootstrap_means_2(b) = mean(boot_sample_2);
    end

    t_stat_orig_1 = sample_mean - 1;
    t_stat_orig_2 = sample_mean - 2;

    p_value_boot_1 = mean(abs(bootstrap_means_1) >= abs(t_stat_orig_1));
    p_value_boot_2 = mean(abs(bootstrap_means_2) >= abs(t_stat_orig_2));

    bootstrap_rejections_H0_1 = bootstrap_rejections_H0_1 + (p_value_boot_1 < alpha);
    bootstrap_rejections_H0_2 = bootstrap_rejections_H0_2 + (p_value_boot_2 < alpha);
end

param_reject_rate_H0_1 = param_rejections_H0_1 / M * 100;
param_reject_rate_H0_2 = param_rejections_H0_2 / M * 100;
bootstrap_reject_rate_H0_1 = bootstrap_rejections_H0_1 / M * 100;
bootstrap_reject_rate_H0_2 = bootstrap_rejections_H0_2 / M * 100;

fprintf('\nΜέρος β:\n');
fprintf('Παραμετρικός έλεγχος - Ποσοστό απορρίψεων για H0: μ = 1: %.2f%%\n', param_reject_rate_H0_1);
fprintf('Bootstrap έλεγχος - Ποσοστό απορρίψεων για H0: μ = 1: %.2f%%\n', bootstrap_reject_rate_H0_1);
fprintf('Παραμετρικός έλεγχος - Ποσοστό απορρίψεων για H0: μ = 2: %.2f%%\n', param_reject_rate_H0_2);
fprintf('Bootstrap έλεγχος - Ποσοστό απορρίψεων για H0: μ = 2: %.2f%%\n', bootstrap_reject_rate_H0_2);
