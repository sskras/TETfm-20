function MMT_2020_saukrs_laborinis_nr_2a

    addpath('interp');

    clc; clf; % close all;
    hold on;
    ylim([2.7 3.5]);

    % skirtingi taškų rinkiniai Lagranžui:
    x2 = linspace(1, 5, 2);
    x3 = linspace(1, 5, 3);
    x5 = linspace(1, 5, 5);
    x7 = linspace(1, 5, 7);
    x9 = linspace(1, 5, 9);
    x_ = linspace(1, 5, 100);

    y2 = f(x2);
    y3 = f(x3);
    y5 = f(x5);
    y7 = f(x7);
    y9 = f(x9);
    y_ = f(x_);

    plot(x9, y9, '*', 'DisplayName', '9 taškai');
    plot(x7, y7, '*', 'DisplayName', '7 taškai');
    plot(x5, y5, '*', 'DisplayName', '5 taškai');
    plot(x3, y3, '*', 'DisplayName', '3 taškai');
    plot(x2, y2, '*', 'DisplayName', '2 taškai');

    % Skaičiuoju Lagranžo daugianario koeficientus
    % kai taškų skaičius kinta:
    [l,L] = lagran(x2, y2);
    yL2 = polyval(l, x_);

    [l,L] = lagran(x3, y3);
    yL3 = polyval(l, x_);

    [l,L] = lagran(x5, y5);
    yL5 = polyval(l, x_);

    [l,L] = lagran(x7, y7);
    yL7 = polyval(l, x_);

    [l,L] = lagran(x9, y9);
    yL9 = polyval(l, x_);

    % Braižau aproksimacijas per taškus:
    title('Aproksimacija Lagranžo daugianariu');
    plot(x_, yL2, 'y', 'DisplayName', 'Lagr. 2 t.');
    plot(x_, yL3, 'b', 'DisplayName', 'Lagr. 3 t.');
    plot(x_, yL5, 'm', 'DisplayName', 'Lagr. 5 t.');
    plot(x_, yL7, 'r', 'DisplayName', 'Lagr. 7 t.');
    plot(x_, yL9, 'g', 'DisplayName', 'Lagr. 9 t.');

    xlabel('x');
    ylabel('y');
    legend;
    grid;
    hold off;
end

% Duotoji funkcija (93052026 mod 6) #0:
function ret = f(x)
    ret = (1+x) ./ log(1+x);
end
