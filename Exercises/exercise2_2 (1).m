lambda = 1;           % Παράμετρος του ρυθμού (rate parameter)
mu = 1 / lambda;       % Μέση τιμή της κατανομής
data = exprnd(mu, 1000,1);   % Παράγουμε 1000 τυχαίες τιμές
hist(data, 50);   % Δημιουργία ιστογράμματος των δεδομένων
xlabel('Τιμές');
ylabel('Συχνότητα');
grid on;
title('Ιστόγραμμα Εκθετικής Κατανομής');
