function MMT_2020_saukrs_laborinis_nr_3()

    clc;
    clear all;
    close all;

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

    % Uždavinyje nagrinėjama funkcija:
    function ret = I(U, I_0, t)
        t = t - abs0;
        ret = I_0 * (exp(U*e / (k*t)) - 1);
    end

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
    % I_{01} (e^{{U e}/{k(t_1 + 273.15})} - 1) - I_1 = 0
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
        t_1  = x(2) - abs0;
        ret(1) = I_01 * (exp(U_a*e / (k*t_1)) - 1) - I_1a;
        ret(2) = I_01 * (exp(U_b*e / (k*t_1)) - 1) - I_1b;
    end

    % Pradiniam taškui parenku:
    % I = 1 A (lempinė vertė)
    % T = 300 K (kambario t)
    x0 = [1, 20];

    % Tikrinu, ar mano f1() skaičiuoja:
    disp('Pradinis taškas x0='); disp(x0);
    disp('f1(x0)='); disp(f1(x0));

    % OK, kažką skaičiuoja:
    %
    % f1(x0)=
    %   102.9049  343.8264
    
    % Kviečiu dėstytojo funkciją, skaičiuojančią pagal 
    % modifikuotą Niutono metodą (su paderinamu žingsnio dydžiu):
    [x,~,~] = newtons(@f1, x0);

    I_01_newt = x(1);
    t_1_newt  = x(2);

    % Kviečiu fsolve():
    options = optimset('Display', 'off', 'MaxIter', 20);
    xfsolve = fsolve(@f1, x0, options);

    I_01_fsol = xfsolve(1);
    t_1_fsol  = xfsolve(2);

    % Duomenys pasitikrinimui iš užduoties:
    I_01_tikr =            1e-6; % A (1 μA)
    t_1_tikr  =             -10; %°C
    t_1_tikr  = t_1_tikr       ; % K

    % Susikuriu funkciją aiškesniam reikšmių vaizdavimui konsolėje:
    function i_konsole(title, I, t)
        title = [title ':'];
        fprintf('%-32s I_01 = %f μA, t=%f °C\n', title, I*1e6, t);
    end

    i_konsole('Apskaičiuota su newtons()',      I_01_newt, t_1_newt);
    i_konsole('Apskaičiuota su fsolve()',       I_01_fsol, t_1_fsol);
    i_konsole('Tikrosios reikšmės (užduotyje)', I_01_tikr, t_1_tikr);

    % Gaunu:
    % Apskaičiuota su newtons():     I_01 = 0.951742 μA, t=-12.890927 °C
    % Apskaičiuota su fsolve():      I_01 = 0.951742 μA, t=-12.890930 °C
    % Tikrosios vertės (užduoty):    I_01 = 1.000000 μA, t=-10.000000 °C

    % Matyti, kad MATLABo fsolve() ir dėstytojo newtons() funkcijos grąžina
    % beveik identiškas reikšmes.
    %
    % Taip pat matyti, kad reikšmės šiek tiek skiriasi nuo tikrųjų.
    % Santykinės paklaidos:
    
    fprintf('\n');
    fprintf('I_0 paklaida: %.3f %%\n', (1 - I_01_newt/I_01_tikr)*100);
    fprintf('t paklaida:   %.3f %%\n', (1 - t_1_newt/t_1_tikr)*100);

    % Gaunu:
    % I_0 paklaida: 4.826 %
    % t paklaida:   -28.909 %

    % Manau, kad paklaidos atsirado dėl atraminių (referinių) taškų 
    % parinkimo iš akies, apytiksliai.

    % Dar tikrinu pasirinktus taškus pagal duotus pasitikrinimo duomenis:
    fprintf('\n');
    fprintf('I(%.3f V) = %f mA\n', U_a, I(U_a, I_01_tikr, t_1_tikr)*1000);
    fprintf('I(%.3f V) = %f mA\n', U_b, I(U_b, I_01_tikr, t_1_tikr)*1000);

    % I(0.120 V) = 0.198083 mA artimas pasirinktiems 0,2 mA.
    % I(0.151 V) = 0.780542 mA artimas pasirinktiems 0,8 mA.

    % Braižau diodo VACh prie rastų I_0 ir t1 reikšmių:

    UU = linspace(-0.05, 0.18, tasku_sk);
    IIn = I(UU, I_01_newt, t_1_newt);
    IIt = I(UU, I_01_tikr, t_1_tikr);

    figure;
    title('Diodo VACh');
    hold on;

    plot(UU, IIn, 'r', 'DisplayName', ['Niutono met., ', mat2str([I_01_newt, t_1_newt])]);
    plot(UU, IIt, 'b', 'DisplayName', ['Tikroji VACh, ', mat2str([I_01_tikr, t_1_tikr])]);

    xlim([-0.05 0.173]);
    ylim([-1e-4 10e-4]);

    box on;
    grid on;
    set(gca, 'xtick', [-0.04:0.02:0.16]);
    set(gca, 'GridLineStyle', ':');
    xlabel('U, V');
    ylabel('I_1, A');
    legend('Location', 'NorthWest');
    hold off;
end % of main
