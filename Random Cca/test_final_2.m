clear;
clc;

room = 2*ones(9,15);  % �������� ��� ������ ��� ����� ��� (9 ������ �� 15 ���������) (1 ��� normal state)
printroom(room);
pause(1);

K = ones(2,3);  % ���������� ������� ��� ��� ���������� ��� ��������
Npef_6 = zeros(9,15);

Npg_n = randi([0 5],9,15) ; % ���������� ��� ��� personal group ����� ����� 5 �����
Npg_i = zeros(9,15);	% ���� ����� �� normal state ���� ����
Npg_e = zeros(9,15);

% �� �������� ��� ��� ������
%Cca   = 0.343;
Cspef = 0.245;
Cspec = 1.02;
Cspg  = 0.177;
A     = 0.1;

R = ones(9,15); % ���� ���� R=1

Cca = 0.4*rand(9, 15);

for t=0:0.1:20
    
    for i=1:9
        for j=1:15
            if R(i,j)>5.953 && room(i,j)==3;    
                room(i,j) = 4;  % 2 ��� evacuating state
                fprintf('To ����� ��� ���� %d,%d', i,j); 
                fprintf(' �������� �� ������ �� ����� %fs \n', t);
            elseif R(i,j)>5.558  && room(i,j)==2;
                room(i,j) = 3; % 0 ��� investigating state
                fprintf('To ����� ��� ���� %d %d', i,j); 
                fprintf(' ��������� ��� ������� �� ����� %fs \n', t); 
            end
        end
    end                
     
    rows = sum(room==2, 2); % ������������ ����� �� normal state �������� �� ���� ����� 
    Npef_1 = [0; cumsum(rows)]; % ���������� ��� ���������� ��� Npef_n
	Npef_1(end,:)=[];
	Npef_2 = Npef_1(:,ones(1,15));
    if Npef_2(2:9,2:14)>3; Npef_3(2:9,2:14) = Npef_2(2:9,2:14) - 3; end
    if Npef_2(2:9,1)>2; Npef_3(2:9,1) = Npef_2(2:9,1) - 2; end
	if Npef_2(2:9,15)>2; Npef_3(2:9,15) = Npef_2(2:9,15) - 2; end
    if t==0; Npef = Npef_3; end;    % ������������ ����� ����� �������� ������ (���� t=0)
    Npef_n = Npef_3;    %   Npef_n
    
    rows = sum(room==4, 2); % ������������ ����� �� evacuating state �������� �� ���� ����� 
    Npef_4 = [0; cumsum(rows)]; % ���������� ��� ���������� ��� Npef_e
	Npef_4(end,:)=[];
	Npef_5 = Npef_4(:,ones(1,15));
    if Npef_5(2:9,2:14)>3; Npef_6(2:9,2:14) = Npef_5(2:9,2:14) - 3; end
    if Npef_5(2:9,1)>2; Npef_6(2:9,1) = Npef_5(2:9,1) - 2; end
	if Npef_5(2:9,15)>2; Npef_6(2:9,15) = Npef_5(2:9,15) - 2; end
    Npef_e = Npef_6; % Npef_e
    Npef_i = Npef - Npef_n - Npef_e;    % Npef_i
     
    B = room==2;    % ������� �� ���� ������ ���� ����� ����� �� normal state
    B = flipud(B);  % ���������� ��� ���������� ��� Npec_n
    M = conv2(double(B), K, 'same') - B;
    if t==0; Npec = flipud(M); end; % ������������ ����� ����� �������� ������� ������ (���� t=0)
    Npec_n = flipud(M); % Npec_n
     
    B = room==4;    % ������� �� ���� ������ ���� ����� ����� �� evacuating state
    B = flipud(B);  % ���������� ��� ���������� ��� Npec_e
    M = conv2(double(B), K, 'same') - B;
    Npec_e = flipud(M); % Npec_e
    Npec_i = Npec - Npec_n - Npec_e;    % Npec_i
    
    % ����������� ��� R
    R1 = exp(Cca*t);  
    %R1 = Cca;
    R2 = Cspef.*((Npef_e+Npef_i)./(Npef_n+Npef_e+Npef_i)).^A;
    R2(isnan(R2))=0;
    R3 = Cspec.*((Npec_e+Npec_i)./(Npec_n+Npec_e+Npec_i)).^A;
    R4 = Cspg.*((Npg_i+Npg_e)./(Npg_n+Npg_e+Npg_i)).^A;
    R4(isnan(R4))=0;
    R = R1 + R2 + R3 + R4;
    printroom(room);
end