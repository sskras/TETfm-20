function MMT_2020_saukrs_laborinis_nr_3()

    clc;

    % Fizikinės konstantos:
    k = 1.380e-23; % J/K
    e = 1.602e-19; % C
    abs0 =-273.15; %°C, absoliutaus nulio t-ra

    % Braižymui:
    tasku_sk = 100;

    % Duota kreivė:
    %
    % $$
    % I = I_0 \cdot (e^{\frac{U \ e}{kT}} - 1) ;
    % $$

    % (93052026 mod 3) = 0, renkuosi I_01, t_1:
    %
    % $$
    % I_1 = I_{01} \cdot (e^{{U e}/{kT_1}} - 1)
    %     = I_{01} \cdot (e^{{U e}/{k(t_1 + 273.15})} - 1) ;
    % $$

    % Rasime nežinomus diodo parametrus I_{01} ir t_1 pagal
    % du laisvai pasirinktus taškus A=(U_a, I_1a) ir B=(U_b, I_1b).
    %
    % Perdarome funkciją į tradicinį lygties formą pavidalą:
    %
    % $$
    % I_{01} (e^{{U e}/{k(t_1 + 273.15})} - 1) - I_1 = 0 =
    %
    % = f_1(I_{01}, t_1) ;
    % $$
    %
    % Sprendžiame lygčių sistemą įstatydami pasirinktus taškus A ir B:
    %
    % $$
    % \begin{cases}
    % f_{1_A}(I_{01}, t_1) = 0 \\
    % f_{1_B}(I_{01}, t_1) = 0
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

    U_a = 0.120; I_1a = 0.2e-3;
    U_b = 0.151; I_1b = 0.8e-3;
    
    function ret = f1(x)
        I_01 = x(1);
        t_1  = x(2);
        ret(1) = I_01 * (exp(U_a*e / (k*t_1)) - 1) - I_1a;
        ret(2) = I_01 * (exp(U_b*e / (k*t_1)) - 1) - I_1b;
    end

    % Tikrinu, ar f1() skaičiuoja:
    disp(f1([0.01, 300]));
    
    % Pradiniam taškui parenku:
    % I = 1 A (lempinė vertė)
    % T = 300 K (kambario t)
    x0 = [1, 300];

    % Kviečiu dėstytojo funkciją, skaičiuojančią pagal 
    % modifikuotą Niutono metodą (su paderinamu žingsnio dydžiu):
    [x,fx,xx] = newtons(@f1, x0);

    fprintf('Apskaičiuota su newtons(): I_01 = %f μA, t=%f °C\n\n', x(1)*1e6, x(2)+abs0);
    
    % Uždavinyje nagrinėjama funkcija:
    function ret = I(U, I_0, t)

        ret = I_0 * (exp(U*e / (k*t)) - 1);
    end

    % Duomenys pasitikrinimui:
    I_01_tikr =            1e-6; % A (1 μA)
    t_1_tikr  =             -10; %°C
    t_1_tikr  = t_1_tikr - abs0; % K

    % Tikrinu pasirinktus taškus pagal duotus pasitikrinimo duomenis:
    fprintf('I(%.3f V) = %f mA\n', U_a, I(U_a)*1000);
    fprintf('I(%.3f V) = %f mA\n', U_b, I(U_b)*1000);

    % I(0.120 V) = 0.198083 mA artimas pasirinktiems 0,2 mA.
    % I(0.151 V) = 0.780542 mA artimas pasirinktiems 0,8 mA.

    % 
end % of main
