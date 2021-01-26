function MMT_2020_saukrs_laborinis_nr_2a

    % Prijungiu funkcijas iš dėstytojo modulių (iš .zip):
    addpath('approx');
    clc; close all;

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

    % Fiksuoju duomenis stulpelių pavidalu:
    x = x1';
    y = yd1';

    % Ištiesinu x į x':
    x_ = 1 ./ x;

    % Lygčių sistemai paruošiu matricą A iš 
    % ... nuskaitytų x1 duomenų pirmame stulpelyje:
    A(:, 1) = x_;
    % ... ir vienetų antrame stulpelyje, formulė (3.8.2):
    A(:, 2) = ones(size(x));

    % Skaičiuoju TLS atsakymą iš A ir y:
    a_b = A \ y
    
    % a_b =
    %     0.5132
    %     4.9786

    % Skaičiuoju y1 pagal vektorių x, koef. a ir b:
    y1 = f(a_b, x1);
    
    % Kviečiu lsqcurvefit(), paduodu:
    %
    % užduoties f-ją,
    % pradinį artinį [5, 1],
    % nuskaitytus duomenis x1 ir yd1
    koef = lsqcurvefit(@f, [5; 1], x1, yd1)

    % Local minimum found.
    %
    % Optimization completed because the size of the gradient is less than
    % the value of the optimality tolerance.
    %
    % <stopping criteria details>
    %
    % koef =
    % 
    %     0.5132
    %     4.9786
    %
    % lsq
    % 
    % Optimization completed: The first-order optimality measure, 1.256496e-07,
    % is less than options.OptimalityTolerance = 1.000000e-06.

    % Apskaičiuoju kreivę pagal naujus koeficientus:
    y_lscf1 = f(koef, x1);

    figure; hold on;

    % Nuskaitytų duomenų diagrama:
    plot(x1, yd1, 'bx');

    % Aproksimacija su "\":
    plot(x1, y1, 'r');

    % Aproksimacija su lsqcurvefit():
    plot(x1, y_lscf1, 'go');

    grid on;
    legend( ...
        'Pateikti duomenys', ...
        'Ištiesinimo aproksimacija su operatorium "\\"', ...
        'Ištiesinimo aproksimacija su lsqcurvefit()' ...
    );

    disp(['lscurvefit() apskaičiuoja lygiai tokius pačius ' ...
        'koeficientus kaip ir A\y, todėl jos rezultatą ' ...
        'y_lscf1 žymiu apskritimais, kad atsiskirtų nuo y1.' ...
    ]);
end % of program.

% Duotoji funkcija (93052026 mod 6) #0:
function ret = f(koef, x)
    a = koef(1);
    b = koef(2);
    ret = a ./ x + b;
end
