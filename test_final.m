clear;
clc;

room = 2*ones(9,15);  % ορίζουμε τις θέσεις του χώρου μας (9 σειρές με 15 καθίσματα) (1 για normal state)
printroom(room);
pause(2);

K = ones(2,3);  % βοηθητικός πίνακας για τον υπολογισμό των κοντινών

Npg_n = randi([0 5],9,15) ; % υποθέτουμε ότι στο personal group είναι μέχρι 5 άτομα
Npg_i = zeros(9,15);	% όλοι είναι σε normal state στην αρχή
Npg_e = zeros(9,15);

% οι σταθερές από τον πίνακα
Cca   = 0.343;
Cspef = 0.245;
Cspec = 1.02;
Cspg  = 0.177;
A     = 0.1;
 
R = ones(9,15); % στην αρχή R=1

for t=0:0.1:10
    
    for i=1:9
        for j=1:15
            if R(i,j)>5.953 && room(i,j)==3;    
                room(i,j) = 4;  % 4 για evacuating state
                fprintf('To άτομο στη θέση %d,%d', i,j); 
                fprintf(' ξεκινάει να αποδρά σε χρόνο %fs \n', t);
                
            elseif R(i,j)>5.558  && room(i,j)==2;
                room(i,j) = 3; % 3 για investigating state
                fprintf('To άτομο στη θέση %d %d', i,j); 
                fprintf(' αντελήφθη τον κίνδυνο σε χρόνο %fs \n', t); 
                
            end
        end
    end                
     
    rows = sum(room==2, 2); % υπολογίζουμε πόσοι σε normal state κάθονται σε κάθε σειρά 
    Npef_1 = [0; cumsum(rows)]; % διαδικασία για υπολογισμό του Npef_n
	Npef_1(end,:)=[];
	Npef_2 = Npef_1(:,ones(1,15));
    Npef_3(2:9,2:14) = Npef_2(2:9,2:14) - 3; 
    Npef_3(2:9,1) = Npef_2(2:9,1) - 2; 
    Npef_3(2:9,15) = Npef_2(2:9,15) - 2;
    if t==0; Npef = Npef_3; end;    % υπολογίζουμε πόσοι είναι συνολικά ορατοί (όταν t=0)
    Npef_n = Npef_3;    %   Npef_n
    
    rows = sum(room==4, 2); % υπολογίζουμε πόσοι σε evacuating state κάθονται σε κάθε σειρά 
    Npef_1 = [0; cumsum(rows)]; % διαδικασία για υπολογισμό του Npef_e
	Npef_1(end,:)=[];
	Npef_2 = Npef_1(:,ones(1,15));
    Npef_3(2:9,2:14) = Npef_2(2:9,2:14) - 3; 
    Npef_3(2:9,1) = Npef_2(2:9,1) - 2; 
    Npef_3(2:9,15) = Npef_2(2:9,15) - 2;
    Npef_e = Npef_3; % Npef_e
    Npef_i = Npef - Npef_n - Npef_e;    % Npef_i
     
    B = room==2;    % κρατάμε σε έναν πίνακα μόνο όσους είναι σε normal state
    B = flipud(B);  % διαδικασία για υπολογισμό του Npec_n
    M = conv2(double(B), K, 'same') - B;
    if t==0; Npec = flipud(M); end; % υπολογίζουμε πόσοι είναι συνολικά κοντινά ορατοί (όταν t=0)
    Npec_n = flipud(M); % Npec_n
     
    B = room==4;    % κρατάμε σε έναν πίνακα μόνο όσους είναι σε evacuating state
    B = flipud(B);  % διαδικασία για υπολογισμό του Npec_e
    M = conv2(double(B), K, 'same') - B;
    Npec_e = flipud(M); % Npec_e
    Npec_i = Npec - Npec_n - Npec_e;    % Npec_i
    
    % υπολογισμός του R
    R1 = exp(Cca*t);  
    R2 = Cspef.*((Npef_e+Npef_i)./(Npef_n+Npef_e+Npef_i)).^A;
    R2(isnan(R2))=0;
    R3 = Cspec.*((Npec_e+Npec_i)./(Npec_n+Npec_e+Npec_i)).^A;
    R4 = Cspg.*((Npg_i+Npg_e)./(Npg_n+Npg_e+Npg_i)).^A;
    R4(isnan(R4))=0;
    R = R1 + R2 + R3 + R4;
    printroom(room);
end