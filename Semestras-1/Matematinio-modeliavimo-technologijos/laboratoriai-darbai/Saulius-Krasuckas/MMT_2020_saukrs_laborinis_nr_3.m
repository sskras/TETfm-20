function MMT_2020_saukrs_laborinis_nr_3()

    clc;

    % Fizikinės konstantos:
    k = 1.38e-23; %  J/K
    e = 1.602e-19; %  C

    % Duota kreivė:
    %
    % $$
    % I = I_0 \cdot (e^{\frac{U \ e}{kT}} - 1) ;
    % $$
    %
    % (93052026 mod 3) = 0, renkuosi I_01, t_1:
    %
    % $$
    % I_1 = I_{01} \cdot (e^{{U e}/{kT_1}} - 1)
    %     = I_{01} \cdot (e^{{U e}/{k(t_1 + 273.15})} - 1) ;
    % $$
    %
    % Rasime nežinomus diodo parametrus I_{01} ir t_1 pagal
    % du laisvai pasirinktus taškus A (U_a, I_1a) ir B (U_b, I_1b).
    %
    % Perdarome funkciją į įprastinį pavidalą:
    %
    % $$
    % I_{01} (e^{{U e}/{k(t_1 + 273.15})} - 1) - I_1 = 0
    % = f_1(I_{01}, t_1) ;
    % $$
    %
    % Sprendžiame lygčių sistemą įstatydami pasirinktus taškus A ir B:
    %
    % $$
    % \begin{cases}
    % f_{1a}(I_{01}, t_1) = 0 \\
    % f_{1b}(I_{01}, t_1) = 0
    % \end{cases}
    % $$
    %
    % $$
    % \begin{cases}
    % I_{01} (e^{{U_a e}/{k(t_1 + 273.15})} - 1) - I_{1a} = 0 \\
    % I_{01} (e^{{U_b e}/{k(t_1 + 273.15})} - 1) - I_{1b} = 0
    % \end{cases}
    % $$

    % 1-oje diagramoje iš akies pasirenku taškus:
    %   (0.12 V, 0,2 mA)
    %   (0.15 V, 0,8 mA)

    U_a = 0.12; I_1a = 0.2e-3;
    U_b = 0.15; I_1b = 0.8e-3;
    
    function ret = f1(x)
        I_01 = x(1);
        t_1  = x(2);
        ret(1) = I_01 * (exp(U_a*e / (k*t_1)) - 1) - I_1a;
        ret(2) = I_01 * (exp(U_b*e / (k*t_1)) - 1) - I_1b;
    end

    disp(f1([1, 300]));
    
    % Funkcija pasitikrinimui:
    function ret = I(U)

        % Duomenys pasitikrinimui:
        I_01 =         1e-6; %  A (1 μA)
        t_1  =          -10; % °C
        t_1  = t_1 + 273.15; %  K

        ret = I_01 * (exp(U*e / (k*t_1)) - 1);
    end

    % Tikrinu pasirinktus taškus pagal pasitikrinimo duomenis:
    fprintf('I(0.12 V) = %f mA\n', I(0.12)*1000);
    fprintf('I(0.15 V) = %f mA\n', I(0.15)*1000);

    % I(0.12 V) = 0.198083 mA artimas pasirinktiems 0,2 mA.
    % I(0.15 V) = 0.746815 mA artimas pasirinktiems 0,8 mA.

    % Bus randa
end % of main
