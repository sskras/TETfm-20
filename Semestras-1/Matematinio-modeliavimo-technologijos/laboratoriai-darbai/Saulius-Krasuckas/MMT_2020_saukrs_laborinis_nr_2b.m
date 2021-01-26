function MMT_2020_saukrs_laborinis_nr_2a

    % Prijungiu funkcijas iš dėstytojo modulių (iš .zip):
    addpath('approx');

    % Duotoji funkcija (93052026 mod 3) yra #0:
    %
    %     y = a/x + b;
    %
    % „Ištiesinta" versija:
    %
    %     y = ax' + b;
    %
    % Pakeitimas:
    %
    %     x' = 1/x;
    %
    % Duomenų failas:
    %
    %     "data1.mat"

    % Iš failo nuskaitome vektorius x1 ir yd1:
    load('data1.mat');

    % Tikrinu x1:
    fprintf('x1(1) = %f\n', x1(1));
    fprintf('x1(end) = %f\n', x1(end));
    fprintf('size(x1) = %s\n', mat2str(size(x1)));
    % x1(1) = 0.100000
    % x1(end) = 10.000000
    % size(x1) = [1 100]

    % Fiksuoju x stulpelio pavidalu:
    x = x1';

    % Lygčių sistemai paruošiu matricą A iš 
    % nuskaitytų x1 duomenų pirmame stulpelyje:
    A(:, 1) = x;
    % ... ir vienetų antrame stulpelyje, formulė (3.8.2):
    A(:, 2) = ones(size(x1));

    % Ištiesinu x į x':
    x_ = 1 ./ x;

    % Skaičiuoju TLS atsakymą:
    theta = A \ x_;

    % Išsitraukiu a ir b:
    a = theta(1);
    b = theta(2);

    % Skaičiuoju y pagal x, a, b:
    y = a/x1 + b;
    
end % of program.
