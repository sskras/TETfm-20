function MMT_2020_saukrs_laborinis_nr_2a

    addpath('interp');

    clc; close all;
    hold on;
    ylim([2.7 3.5]);

    eile = 1; % aproksimacijos eilė
    Lagran_vkkl = 2; % Lagr. vidutinė kvadratinė klaida
    Lagran_makl = 3; % Lagr. maksimali klaida

    aproksim = {};
    aproksim(eile, :) = {2, 3, 5, 7, 9};

    % Tikrinu celės elementų indeksaciją:
  % for i = 1:length(aproksim)
  %     fprintf("%d ", aproksim{eile, i});
  % end

    % Programinis indekso radimas pagal eilę,
    % pvz. 7-ta eilė grąžina 4-tą indeksą:
  % find([aproksim{eile, :}] == 7)

    % Šįkart apsieisiu panaudodamas konstantas, vaizdžiau:
    eil2 = 1;
    eil3 = 2;
    eil5 = 3;
    eil7 = 4;
    eil9 = 5;

    % x-masyvas daugianarių braižymui:
    x_ = linspace(1, 5, 100);
    % y-masyvas su tikrosiomis reikšmėmis:
    y_ = f(x_);

    % skirtingi taškų rinkiniai Lagranžui:
    x2 = linspace(1, 5, 2);
    x3 = linspace(1, 5, 3);
    x5 = linspace(1, 5, 5);
    x7 = linspace(1, 5, 7);
    x9 = linspace(1, 5, 9);

  % Galbūt būtų gražiau ir referinius taškus sukišti į celę.
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

    % Atvaizduoju referinius taškus atvirkštine tvarka, 
    % kad ne tankesni taškai užgožtų retesnius, o atv.:
    plot(x9, y9, '*', 'DisplayName', '9 taškai');
    plot(x7, y7, '*', 'DisplayName', '7 taškai');
    plot(x5, y5, '*', 'DisplayName', '5 taškai');
    plot(x3, y3, '*', 'DisplayName', '3 taškai');
    plot(x2, y2, '*', 'DisplayName', '2 taškai');

    % Skaičiuoju Lagranžo daugianario koeficientus
    % kai taškų skaičius kinta:
    [l2,~] = lagran(x2, y2);
    [l3,~] = lagran(x3, y3);
    [l5,~] = lagran(x5, y5);
    [l7,~] = lagran(x7, y7);
    [l9,~] = lagran(x9, y9);

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

    title('Aproksimacija Lagranžo daugianariu');
    % Braižau 100 taškų aproksimacijas per pradinius taškus:
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

    figure;
    hold on;

    title('Maksimali ir vidutinė kvadratinė klaidos');
    % Atvaizduoju vidutinės kvadratinės ir maksimalios
    % klaidų priklausomybes nuo aproksimavimo eilės:
    plot([aproksim{eile,:}], [aproksim{Lagran_vkkl,:}], 'r', 'DisplayName', 'Lagran_vkkl');
    plot([aproksim{eile,:}], [aproksim{Lagran_makl,:}], 'g', 'DisplayName', 'Lagran_makl');

    xlabel('aproksimavimo eilė');
    ylabel('klaidos dydis');
    grid;
    hold off;
end

% Duotoji funkcija (93052026 mod 6) #0:
function ret = f(x)
    ret = (1+x) ./ log(1+x);
end
