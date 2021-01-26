% Duotoji kreivė (93052026 mod 3) = 0:
%
%   I_01, t_1
%
% Joje iš akies pasirenku tašką:
%
%   (0.12 V, 0,2 μA)

I(0.12)

function ret = I(U)

    % Duomenys pasitikrinimui:
    I_01 =         1e-6; %  A (1 μA)
    t_1  =          -10; % °C
    t_1  = t_1 + 273.15; %  K

    % Fizikinės konstantos:
    k    =     1.38e-23; %  J/K
    e    =    1.602e-19; %  C

    ret = I_01 * (exp(U*e / (k*t_1)) - 1);
end
