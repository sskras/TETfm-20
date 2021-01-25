function MMT_2020_saukrs_laborinis_nr_2a

    % Prijungiu funkcijas iš dėstytojo modulių (iš .zip):
    addpath('interp');

    % Duotoji funkcija (93052026 mod 6) yra #0. Kodas apačioje:
    % 
    % function ret = f(x)
    %     ret = (1+x) ./ log(1+x);
    % end

    % Interpoliacijos intervalas:
    x_min = 1;
    x_max = 5;

    % Aproksimacijų braižymui:
    diagramos_tasku_sk = 100;

    % Programa braižo 7 diagramas:
    %
    % (Figure 1) atvaizduota 2-os eilės aproksimacija
    % (Figure 2) atvaizduota 3-os eilės aproksimacija
    % (Figure 3) atvaizduota 5-os eilės aproksimacija
    % (Figure 4) atvaizduota 7-os eilės aproksimacija
    % (Figure 5) atvaizduota 9-os eilės aproksimacija
    % (Figure 6) atvaizduota vidutinės kv. klaidos kitimai
    % (Figure 7) atvaizduota maksimalios klaidos kitimai

    clc; close all;

    % Konstantos indeksuoti celės eilutėms:
    %
    eile        = 1; % aproksimacijos eilės
    Lagran_vkkl = 2; % Lagr. vidutinė kvadratinė klaida
    Lagran_makl = 3; % Lagr. maksimali klaida
    Cebyse_vkkl = 4; % Čeby. vidutinė kvadratinė klaida
    Cebyse_makl = 5; % Čeby. maksimali klaida
    Pade_vkkl   = 6; % Padė vidutinė kvadratinė klaida
    Pade_makl   = 7; % Padė maksimali klaida
    Spline_vkkl = 8; % Spline vidutinė kvadratinė klaida
    Spline_makl = 9; % Spline maksimali klaida

    rez = {};
    rez(eile, :) = {2, 3, 5, 7, 9};

    % Mokinuosi celės elementų indeksaciją:

  % for i = 1:length(rez)
  %     fprintf("%d ", rez{eile, i});
  % end

    % Programinis indekso radimas pagal eilės dydį,
    % pvz. 7-ta eilė grąžina 4-tą indeksą:

  % find([rez{eile, :}] == 7)

    % Šįkart apsieisiu panaudodamas tik konstantas, vaizdžiau:
    eil2 = 1;
    eil3 = 2;
    eil5 = 3;
    eil7 = 4;
    eil9 = 5;

    % x-masyvas daugianarių braižymui:
    x_ = linspace(x_min, x_max, diagramos_tasku_sk);
    % y-masyvas su tikrosiomis reikšmėmis:
    y_ = f(x_);

    % skirtingų eilių x-taškai Lagranžui ir Niutonui:
    x2 = linspace(x_min, x_max, 2);
    x3 = linspace(x_min, x_max, 3);
    x5 = linspace(x_min, x_max, 5);
    x7 = linspace(x_min, x_max, 7);
    x9 = linspace(x_min, x_max, 9);

    y2 = f(x2);
    y3 = f(x3);
    y5 = f(x5);
    y7 = f(x7);
    y9 = f(x9);

%   % Skaičiuoju Lagranžo daugianario koeficientus
    % kai taškų skaičius kinta:
    [l2,~] = lagranp(x2, y2);
    [l3,~] = lagranp(x3, y3);
    [l5,~] = lagranp(x5, y5);
    [l7,~] = lagranp(x7, y7);
    [l9,~] = lagranp(x9, y9);

    % Pagal Lagranžo koef-us apskaičiuoju 
    % po 100 taškų diagramai:
    yL2 = polyval(l2, x_);
    yL3 = polyval(l3, x_);
    yL5 = polyval(l5, x_);
    yL7 = polyval(l7, x_);
    yL9 = polyval(l9, x_);

    % Lagranžo aproksimacijų vidutinė kvadratinė klaida:
    rez{Lagran_vkkl, eil2} = immse(y_, yL2);
    rez{Lagran_vkkl, eil3} = immse(y_, yL3);
    rez{Lagran_vkkl, eil5} = immse(y_, yL5);
    rez{Lagran_vkkl, eil7} = immse(y_, yL7);
    rez{Lagran_vkkl, eil9} = immse(y_, yL9);

    % Lagranžo aproksimacijų maksimali klaida:
    rez{Lagran_makl, eil2} = max(abs(y_ - yL2));
    rez{Lagran_makl, eil3} = max(abs(y_ - yL3));
    rez{Lagran_makl, eil5} = max(abs(y_ - yL5));
    rez{Lagran_makl, eil7} = max(abs(y_ - yL7));
    rez{Lagran_makl, eil9} = max(abs(y_ - yL9));

%   % Skaičiuoju Niutono daugianario koeficientus
    % kai taškų skaičius kinta:
    N2 = niutonp(x2, y2);
    N3 = niutonp(x3, y3);
    N5 = niutonp(x5, y5);
    N7 = niutonp(x7, y7);
    N9 = niutonp(x9, y9);

    % Pagal Niutono koeficientus apskaičiuoju 
    % po 100 taškų diagramai:
    yN2 = polyval(N2, x_);
    yN3 = polyval(N3, x_);
    yN5 = polyval(N5, x_);
    yN7 = polyval(N7, x_);
    yN9 = polyval(N9, x_);

    % Niutono aproksimacijų klaidų neskaičiuosime (pagal užduotį)

%   % Skaičiuoju Čebyševo daugianario koeficientus
    % kai taškų skaičius kinta:
    [c2, xm2, ym2] = cheby(@f, 2-1, x_min, x_max);
    [c3, xm3, ym3] = cheby(@f, 3-1, x_min, x_max);
    [c5, xm5, ym5] = cheby(@f, 5-1, x_min, x_max);
    [c7, xm7, ym7] = cheby(@f, 7-1, x_min, x_max);
    [c9, xm9, ym9] = cheby(@f, 9-1, x_min, x_max);
    % Taip pat ir Čebyševo mazgus [xm ym].
    % (Čia taškų skaičiui -1, nes metodas grąžina +1 koef.)

    % Pagal Čebyševo koeficientus apskaičiuoju 
    % po 100 taškų diagramai:
    yC2 = polyval(c2, x_);
    yC3 = polyval(c3, x_);
    yC5 = polyval(c5, x_);
    yC7 = polyval(c7, x_);
    yC9 = polyval(c9, x_);

    % Čebyševo aproksimacijų vidutinė kvadratinė klaida:
    rez{Cebyse_vkkl, eil2} = immse(y_, yC2);
    rez{Cebyse_vkkl, eil3} = immse(y_, yC3);
    rez{Cebyse_vkkl, eil5} = immse(y_, yC5);
    rez{Cebyse_vkkl, eil7} = immse(y_, yC7);
    rez{Cebyse_vkkl, eil9} = immse(y_, yC9);

    % Čebyševo aproksimacijų maksimali klaida:
    rez{Cebyse_makl, eil2} = max(abs(y_ - yC2));
    rez{Cebyse_makl, eil3} = max(abs(y_ - yC3));
    rez{Cebyse_makl, eil5} = max(abs(y_ - yC5));
    rez{Cebyse_makl, eil7} = max(abs(y_ - yC7));
    rez{Cebyse_makl, eil9} = max(abs(y_ - yC9));

%   % Skaičiuoju Padė daugianarių koeficientus
    % kai taškų skaičius kinta:

    % Skleidimui Teiloro eilute pasirenku x-tašką maždaug
    % ten, kur funkcija kinta staigiausiai:
    x0 = 1.8;

    % Kadangi daugianariai du, bandau nurodytą apskroksimavimo eilę
    % išskaidyt per juos abu, o ne kopijuoti į juos abu. Pvz. taip:
    % 2 = 1 + 1 eilės
    % 3 = 2 + 1 eilės
    % 5 = 3 + 2 eilės (paskaitos pavyzdys)
    % 7 = 4 + 3 eilės
    % 9 = 5 + 4 eilės
    %
    % Nei teorijoje, nei užduotyje nerandu, kaip tiksliai įvardinta
    % Padė racionacioniosios f-jos eilė (ją skaidant ar kopijuojant)
    %
    [Skai2, Vard2, Teil2] = padeap(@f, x0, 1, 1, x_min, x_max);
    [Skai3, Vard3, Teil3] = padeap(@f, x0, 2, 1, x_min, x_max);
    [Skai5, Vard5, Teil5] = padeap(@f, x0, 3, 2, x_min, x_max);
    [Skai7, Vard7, Teil7] = padeap(@f, x0, 4, 3, x_min, x_max);
    [Skai9, Vard9, Teil9] = padeap(@f, x0, 5, 4, x_min, x_max);

    yP2 = polyval(Skai2, x_-x0) ./ polyval(Vard2, x_-x0);
    yP3 = polyval(Skai3, x_-x0) ./ polyval(Vard3, x_-x0);
    yP5 = polyval(Skai5, x_-x0) ./ polyval(Vard5, x_-x0);
    yP7 = polyval(Skai7, x_-x0) ./ polyval(Vard7, x_-x0);
    yP9 = polyval(Skai9, x_-x0) ./ polyval(Vard9, x_-x0);

    % Skaičiuoju Padė koef-ų radimui panaudoto skleidinio
    % Teiloro eilute aproksimuotą f-ją (formuluotė brrr):

    yT2 = polyval(Teil2, x_-x0);
    yT3 = polyval(Teil3, x_-x0);
    yT5 = polyval(Teil5, x_-x0);
    yT7 = polyval(Teil7, x_-x0);
    yT9 = polyval(Teil9, x_-x0);

    % Padė aproksimacijų vidutinė kvadratinė klaida:
    rez{Pade_vkkl, eil2} = immse(y_, yP2);
    rez{Pade_vkkl, eil3} = immse(y_, yP3);
    rez{Pade_vkkl, eil5} = immse(y_, yP5);
    rez{Pade_vkkl, eil7} = immse(y_, yP7);
    rez{Pade_vkkl, eil9} = immse(y_, yP9);

    % Padė aproksimacijų maksimali klaida:
    rez{Pade_makl, eil2} = max(abs(y_ - yP2));
    rez{Pade_makl, eil3} = max(abs(y_ - yP3));
    rez{Pade_makl, eil5} = max(abs(y_ - yP5));
    rez{Pade_makl, eil7} = max(abs(y_ - yP7));
    rez{Pade_makl, eil9} = max(abs(y_ - yP9));

%   % Skaičiuoju splainų y-taškus pagal x-taškus
    % kai referinių taškų skaičius kinta:

    yS2 = spline(x2, y2, x_);
    yS3 = spline(x3, y3, x_);
    yS5 = spline(x5, y5, x_);
    yS7 = spline(x7, y7, x_);
    yS9 = spline(x9, y9, x_);

    % Spline aproksimacijų vidutinė kvadratinė klaida:
    rez{Spline_vkkl, eil2} = immse(y_, yS2);
    rez{Spline_vkkl, eil3} = immse(y_, yS3);
    rez{Spline_vkkl, eil5} = immse(y_, yS5);
    rez{Spline_vkkl, eil7} = immse(y_, yS7);
    rez{Spline_vkkl, eil9} = immse(y_, yS9);

    % Spline aproksimacijų maksimali klaida:
    rez{Spline_makl, eil2} = max(abs(y_ - yS2));
    rez{Spline_makl, eil3} = max(abs(y_ - yS3));
    rez{Spline_makl, eil5} = max(abs(y_ - yS5));
    rez{Spline_makl, eil7} = max(abs(y_ - yS7));
    rez{Spline_makl, eil9} = max(abs(y_ - yS9));

    % ---- Atvaizdavimas ----

    % Vienos eilės proksimacijų šeima:
    n_tosios_eiles_aproksimaciju_diagrama( ...
        2, x2, y2, xm2, ym2, x_, yL2, yN2, yC2, yP2, yT2, yS2);
    n_tosios_eiles_aproksimaciju_diagrama( ...
        3, x3, y3, xm3, ym3, x_, yL3, yN3, yC3, yP3, yT3, yS3);
    n_tosios_eiles_aproksimaciju_diagrama( ...
        5, x5, y5, xm5, ym5, x_, yL5, yN5, yC5, yP5, yT5, yS5);
    n_tosios_eiles_aproksimaciju_diagrama( ...
        7, x7, y7, xm7, ym7, x_, yL7, yN7, yC7, yP7, yT7, yS7);
    n_tosios_eiles_aproksimaciju_diagrama( ...
        9, x9, y9, xm9, ym9, x_, yL9, yN9, yC9, yP9, yT9, yS9);

    % Visų eilių klaidos priklausomybė:
    klaidos_priklausomybes_nuo_eiles_diagrama( ...
        'Vidutinė kvadratinė', [rez{eile,:}], ...
        [rez{Lagran_vkkl,:}], ...
        [rez{Cebyse_vkkl,:}], ...
        [rez{Pade_vkkl,:}], ...
        [rez{Spline_vkkl,:}] ...
    )
    klaidos_priklausomybes_nuo_eiles_diagrama( ...
        'Maksimali', [rez{eile,:}], ...
        [rez{Lagran_makl,:}], ...
        [rez{Cebyse_makl,:}], ...
        [rez{Pade_makl,:}], ...
        [rez{Spline_makl,:}] ...
    )
end % of program.

function n_tosios_eiles_aproksimaciju_diagrama( ...
    n, xn, yn, xmn, ymn, x_, yLn, yNn, yCn, yPn, yTn, ySn)

    % Pernaudosiu n kaip stringą diagramos apiforminimui:
    n = strcat(' ', string(n));

    figure;
    hold on;    
    title(strcat(n, '-os eilės aproksimacija'));
    % Braižau 100 taškų aproksimacijas per du taškus:
    plot(x_,  yLn, 'm', 'DisplayName', 'Lagranžo daugianariu');
    plot(x_,  yNn, 'y', 'DisplayName', 'Niutono daugianariu');
    plot(x_,  yCn, 'r', 'DisplayName', 'Čebyševo daugianariu');
    plot(x_,  yPn, 'g', 'DisplayName', 'Padė daugianariais');
    plot(x_,  yTn, 'b', 'DisplayName', 'Teiloro eilute iš Padė');
    plot(x_,  ySn, 'c', 'DisplayName', 'Spline daugianariais');
    % Atvaizduoju referinius taškus:
    plot(xn,   yn, 'o', 'DisplayName', strcat(string(length(yn)), ' taškai L+N.'));
    plot(xmn, ymn, 'o', 'DisplayName', strcat(string(length(ymn)), ' mazgai Č.'));

    xlabel('x');
    ylabel('y');
    legend;
    grid;
    ylim([2.7 3.8]);
    hold off;
end

function klaidos_priklausomybes_nuo_eiles_diagrama( ...
    klaidos_tipas, eile, ...
    L_klaida, C_klaida, P_klaida, S_klaida)
% Atvaizduoju klaidos priklausomybę nuo aproksimavimo eilės:
    figure;
    hold on;
    title([klaidos_tipas ' klaida']);

    plot(eile, L_klaida, 'm', 'DisplayName', 'Lagranžo daugianariui');
    plot(eile, C_klaida, 'r', 'DisplayName', 'Čebyševo daugianariui');
    plot(eile, P_klaida, 'g', 'DisplayName', 'Padė daugianariams');
    plot(eile, S_klaida, 'c', 'DisplayName', 'Spline daugianariams');

    xlabel('aproksimavimo eilė');
    ylabel('klaidos dydis');
    legend;
    grid;
    hold off;
end

% Duotoji funkcija (93052026 mod 6) #0:
function ret = f(x)
    ret = (1+x) ./ log(1+x);
end
