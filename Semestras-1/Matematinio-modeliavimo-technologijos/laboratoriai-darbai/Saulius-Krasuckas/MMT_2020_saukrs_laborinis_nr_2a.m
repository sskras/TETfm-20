function MMT_2020_saukrs_laborinis_nr_2a

    addpath('interp');

    clc; close all;

    % Interpoliacijos intervalas:
    x_min = 1;
    x_max = 5;

    % Konstantos indeksuoti celės eilutėms:
    %
    eile        = 1; % aproksimacijos eilė
    Lagran_vkkl = 2; % Lagr. vidutinė kvadratinė klaida
    Lagran_makl = 3; % Lagr. maksimali klaida
    Niuton_vkkl = 4; % Niut. vidutinė kvadratinė klaida
    Niuton_makl = 5; % Niut. maksimali klaida
    Cebyse_vkkl = 6; % Čeby. vidutinė kvadratinė klaida
    Cebyse_makl = 7; % Čeby. maksimali klaida

    aproksim = {};
    aproksim(eile, :) = {2, 3, 5, 7, 9};

    % Tikrinu celės elementų indeksaciją:
  % for i = 1:length(aproksim)
  %     fprintf("%d ", aproksim{eile, i});
  % end

    % Programinis indekso radimas pagal eilę,
    % pvz. 7-ta eilė grąžina 4-tą indeksą:
  % find([aproksim{eile, :}] == 7)

    % Šįkart apsieisiu panaudodamas tik konstantas, vaizdžiau:
    eil2 = 1;
    eil3 = 2;
    eil5 = 3;
    eil7 = 4;
    eil9 = 5;

    % x-masyvas daugianarių braižymui:
    x_ = linspace(x_min, x_max, 100);
    % y-masyvas su tikrosiomis reikšmėmis:
    y_ = f(x_);

    % skirtingų eilių x-taškai Lagranžui ir Niutonui:
    x2 = linspace(x_min, x_max, 2);
    x3 = linspace(x_min, x_max, 3);
    x5 = linspace(x_min, x_max, 5);
    x7 = linspace(x_min, x_max, 7);
    x9 = linspace(x_min, x_max, 9);

  % Gal būtų gražiau ir referinius taškus sukišti į t.p. celę.
  % TODO:
  % aproksim{Lagran_x, eil2} = linspace(1, 5, 2);
  % aproksim{Lagran_x, eil3} = linspace(1, 5, 3);
  % aproksim{Lagran_x, eil5} = linspace(1, 5, 5);
  % aproksim{Lagran_x, eil7} = linspace(1, 5, 7);
  % aproksim{Lagran_x, eil9} = linspace(1, 5, 9);

    y2 = f(x2);
    y3 = f(x3);
    y5 = f(x5);
    y7 = f(x7);
    y9 = f(x9);

    % ---- ----

    % Skaičiuoju Lagranžo daugianario koeficientus
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
    aproksim{Lagran_vkkl, eil2} = immse(y_, yL2);
    aproksim{Lagran_vkkl, eil3} = immse(y_, yL3);
    aproksim{Lagran_vkkl, eil5} = immse(y_, yL5);
    aproksim{Lagran_vkkl, eil7} = immse(y_, yL7);
    aproksim{Lagran_vkkl, eil9} = immse(y_, yL9);

    % Lagranžo aproksimacijų maksimali klaida:
    aproksim{Lagran_makl, eil2} = max(abs(y_ - yL2));
    aproksim{Lagran_makl, eil3} = max(abs(y_ - yL3));
    aproksim{Lagran_makl, eil5} = max(abs(y_ - yL5));
    aproksim{Lagran_makl, eil7} = max(abs(y_ - yL7));
    aproksim{Lagran_makl, eil9} = max(abs(y_ - yL9));

    % ---- ----

    % Skaičiuoju Niutono daugianario koeficientus
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

    % Niutono aproksimacijų vidutinė kvadratinė klaida:
    aproksim{Niuton_vkkl, eil2} = immse(y_, yN2);
    aproksim{Niuton_vkkl, eil3} = immse(y_, yN3);
    aproksim{Niuton_vkkl, eil5} = immse(y_, yN5);
    aproksim{Niuton_vkkl, eil7} = immse(y_, yN7);
    aproksim{Niuton_vkkl, eil9} = immse(y_, yN9);

    % Niutono aproksimacijų maksimali klaida:
    aproksim{Niuton_makl, eil2} = max(abs(y_ - yN2));
    aproksim{Niuton_makl, eil3} = max(abs(y_ - yN3));
    aproksim{Niuton_makl, eil5} = max(abs(y_ - yN5));
    aproksim{Niuton_makl, eil7} = max(abs(y_ - yN7));
    aproksim{Niuton_makl, eil9} = max(abs(y_ - yN9));

    % ---- ----

    % Skaičiuoju Čebyševo daugianario koeficientus
    % kai taškų skaičius kinta:
    [c2, xm2, ym2] = cheby(@f, 2-1, x_min, x_max);
    [c3, xm3, ym3] = cheby(@f, 3-1, x_min, x_max);
    [c5, xm5, ym5] = cheby(@f, 5-1, x_min, x_max);
    [c7, xm7, ym7] = cheby(@f, 7-1, x_min, x_max);
    [c9, xm9, ym9] = cheby(@f, 9-1, x_min, x_max);
    % Taip pat ir Čebyševo mazgus [xm ym].
    % (Čia taškų skaičius -1, nes metodas grąžina +1 koef.)

    % Pagal Čebyševo koeficientus apskaičiuoju 
    % po 100 taškų diagramai:
    yC2 = polyval(c2, x_);
    yC3 = polyval(c3, x_);
    yC5 = polyval(c5, x_);
    yC7 = polyval(c7, x_);
    yC9 = polyval(c9, x_);

    % Niutono aproksimacijų vidutinė kvadratinė klaida:
    aproksim{Cebyse_vkkl, eil2} = immse(y_, yC2);
    aproksim{Cebyse_vkkl, eil3} = immse(y_, yC3);
    aproksim{Cebyse_vkkl, eil5} = immse(y_, yC5);
    aproksim{Cebyse_vkkl, eil7} = immse(y_, yC7);
    aproksim{Cebyse_vkkl, eil9} = immse(y_, yC9);

    % Niutono aproksimacijų maksimali klaida:
    aproksim{Cebyse_makl, eil2} = max(abs(y_ - yC2));
    aproksim{Cebyse_makl, eil3} = max(abs(y_ - yC3));
    aproksim{Cebyse_makl, eil5} = max(abs(y_ - yC5));
    aproksim{Cebyse_makl, eil7} = max(abs(y_ - yC7));
    aproksim{Cebyse_makl, eil9} = max(abs(y_ - yC9));

    % ---- Atvaizdavimas ----

    % Paprogramė aproksimacijų šeimos piešimui:
    n_tosios_eiles_aproksimaciju_diagrama(2, x2, y2, xm2, ym2, x_, yL2, yN2, yC2);
    n_tosios_eiles_aproksimaciju_diagrama(3, x3, y3, xm3, ym3, x_, yL3, yN3, yC3);
    n_tosios_eiles_aproksimaciju_diagrama(5, x5, y5, xm5, ym5, x_, yL5, yN5, yC5);
    n_tosios_eiles_aproksimaciju_diagrama(7, x7, y7, xm7, ym7, x_, yL7, yN7, yC7);
    n_tosios_eiles_aproksimaciju_diagrama(9, x9, y9, xm9, ym9, x_, yL9, yN9, yC9);

    figure;
    hold on;
    title('Maksimali ir vidutinė kvadratinė klaidos');
    % Atvaizduoju vidutinės kvadratinės ir maksimalios
    % klaidų priklausomybes nuo aproksimavimo eilės:
    plot([aproksim{eile,:}], [aproksim{Lagran_vkkl,:}], 'r', 'DisplayName', 'Lagranžo vid. kv.');
    plot([aproksim{eile,:}], [aproksim{Lagran_makl,:}], 'g', 'DisplayName', 'Lagranžo maksimali');
    % Panašu, kad „Niutono" kreivės visiškai paslepia 
    % Lagranžo kreives. Bet vaizduokim vis tiek:
    plot([aproksim{eile,:}], [aproksim{Niuton_vkkl,:}], 'b', 'DisplayName', 'Niutono vid. kv.');
    plot([aproksim{eile,:}], [aproksim{Niuton_makl,:}], 'm', 'DisplayName', 'Niutono maksimali');
    %
    plot([aproksim{eile,:}], [aproksim{Cebyse_vkkl,:}], 'y', 'DisplayName', 'Čebyševo vid. kv.');
    plot([aproksim{eile,:}], [aproksim{Cebyse_makl,:}], 'c', 'DisplayName', 'Čebyševo maksimali');
    %
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

function n_tosios_eiles_aproksimaciju_diagrama(n, xn, yn, xmn, ymn, x_, yLn, yNn, yCn)
    figure;
    hold on;
    title('n-tos eilės aproksimacijos');
    % Braižau 100 taškų aproksimacijas per du taškus:
    plot(x_, yLn, 'b', 'DisplayName', 'Lagr. n t.');
    plot(x_, yNn, 'm', 'DisplayName', 'Niut. n t.');
    plot(x_, yCn, 'r', 'DisplayName', 'Čeby. n t.');
    % Atvaizduoju referinius taškus:
    plot(xn, yn, '*', 'DisplayName', 'n taškai L+N');
    plot(xmn, ymn, '*', 'DisplayName', 'n mazgai Č');
    %
    xlabel('x');
    ylabel('y');
    legend;
    grid;
    ylim([2.7 3.5]);
    hold off;
end
