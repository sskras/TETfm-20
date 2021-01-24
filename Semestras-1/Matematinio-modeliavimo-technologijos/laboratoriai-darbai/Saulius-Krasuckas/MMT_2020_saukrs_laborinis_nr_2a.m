function MMT_2020_saukrs_laborinis_nr_2a
    clc;
    addpath('interp');

    % skirtingi taškų rinkiniai Lagranžui:
    x2 = linspace(1, 5, 2);
    x3 = linspace(1, 5, 3);
    x5 = linspace(1, 5, 5);
    x7 = linspace(1, 5, 7);
    x9 = linspace(1, 5, 9);

    y2 = f(x2);
    y3 = f(x3);
    y5 = f(x5);
    y7 = f(x7);
    y9 = f(x9);

    [l,L] = lagran(x2, y2);
end

% y = f(x)
function ret = f(x)
    ret = (1+x) ./ log(1+x);
end
