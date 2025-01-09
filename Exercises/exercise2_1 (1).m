%% Πίνακας αριθμών ρίψεων
n=[];
for i=1:1000
    n=[n;20*i];
end
line=0.5*ones(1,length(n));
%% Πίνακας αποθήκευσης πιθανότητας εύρεσης γράμματος
probabilities=[];
for i=1:size(n)
    probabilities = [probabilities Calculation(n(i))];
end
plot(n,probabilities,n,line);
xlabel('Αριθμός ρίψεων');
ylabel('Πιθανότητα εμφάνισης γράμματος');
grid on;
%% υλοποίηση συνάρτησης υπολογισμού πιθανότητας
function probability=Calculation(n)
    data=rand(1,n); % δημιουργία τυχαίων αριθμών και αποθήκευση σε μορφή πίνακα σειράς
    letters=0;
    for i=[1:n]
        if data(i)>=0.5
            letters=letters+1; % ορίζουμε ως επιλογή αν έρθει νούμερο μεγαλύτερο απο 0.5 να είναι γράμμα
        end
    end
    probability=letters/n; % λόγος σχετικής συχνότητας με αριθμό ρίψεων
end