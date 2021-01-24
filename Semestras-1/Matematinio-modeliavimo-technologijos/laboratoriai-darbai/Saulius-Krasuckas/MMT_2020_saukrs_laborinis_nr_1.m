function MMT_2020_saukrs_laboratorinis_nr1()
% pagrindinė programa:

    clc;
    close all;
    clear all;
    hold on;
    
    P = 100;     % pradinė reikšmė stiprinimo matricai
    times = 3;  % tiek skirtingų pr. reikšmių naudosime
    
    for iter = 1:times
        % Stiprinimo matricos pradines vertes imame vis 10x didesnes ir
        % perduodame į funkciją, dirbančią su konkrečiais duomenimis:
        [K1, K2] = rlse_saukrs(P);
        k1(iter,:) = K1;
        k2(iter,:) = K2;

        P = P * 10; % reikšmę stiprinimo matricai didiname 10x
    end
    
    fprintf("x(k1, k2) tikrosios vertės: \t %f, %f\n", 5/7, -17-7/9);
    
  % scatter(1:times, k1, 'filled', 'DisplayName', 'k1');
  % scatter(1:times, k2, 'filled', 'DisplayName', 'k2');
  
    % Diagramos apipavidalinimas:
    xlabel('iteracija');
  % ylabel('apsk. koeficientai');
    legend;
    grid;
    hold off;
% end of main

function[k1 k2] = rlse_saukrs(P)
% mano funkcija, skirta k1, k2 įverčių radimui dviems skirtingais būdais
% panaudojant fiksuotą stiprinimo matricą;

    % Duomenys iš užduoties:
    t_C = [13 14 17 18 19 15 13 31 32 29 27];
    t_F = [55 58 63 65 66 59 56 87 90 85 81];
    
    fprintf("P=%d\n", P);
    k_num = 1:length(t_C);
    P_str = string(P);
    
    N = 2;              % 2 lygtys (2 nežinomieji)
    x = zeros(N, 1);    % pradinių (k1, k2) verčių matrica (nuliai)
    P = P * eye(N, N);  % stiprinimo matricos pradinės vertės
    
    xx = [];
    KK = [];
    
    for k = 1:length(t_C)   % iteracijų darau tiek, kiek duota matavimų
        A(k,:) = [t_F(k) 1];% k-toji A eilutė
        b(k,:) =  t_C(k);   % k-toji b eilutė
        
        % Kviečiu pavyzdinę RLSE funkciją k-eilutei
        % :
        [x, K, P] = rlse_online(A(k,:), b(k,:), x, P);
        xx = [xx x];
      % disp(K);
      % KK = [KK abs(K)];
        KK = [KK abs(K)];
    end

    % Pasitikrinimui nubrėžiu x(1) ir x(2) reikšmes,
    % apskaičiuotas kiekvienos iteracijos metu:
  % scatter(k_num, xx(1,:), 'filled', 'DisplayName', 'x1, P=' + P_str);
  % scatter(k_num, xx(2,:), 'filled', 'DisplayName', 'x2, P=' + P_str);

    % Vaizduoju K matricos elementų (ar jų modulių) kitimą 
    % priklausomai nuo iteracijų:
    plot(k_num, KK(1,:), 'DisplayName', 'K(1,:), P=' + P_str);
    plot(k_num, KK(2,:), 'DisplayName', 'K(2,:), P=' + P_str);

    % Taip pat apskaičiuoju k1,k2 įverčius pinv() pagalba pagal A ir b:
    xpi = pinv(A) * b;
    
    fprintf("x(k1, k2) įvertis pagal RLSE: \t %f, %f\n", x(1), x(2));
    fprintf("x(k1, k2) įvertis pagal pinv: \t %f, %f\n\n", xpi(1), xpi(2));
    
    k1 = x(1);
    k2 = x(2);
% end of fn 

function[x, K, P] = rlse_online(aT_k1, b_k1, x, P)
% RLSE algoritmo funkcija (pavyzdžio kopija):

    K = P * aT_k1' / (aT_k1 * P * aT_k1' + 1)   %Eq.(18) %nuimti ";" ir pavaizduoti K matricos verte, kuri mazeja, kai iteraciju daugeja
    x = x + K * (b_k1 - aT_k1 * x);             %Eq.(17)
    P = P - K * aT_k1 * P;                      %Eq.(19)
% enf of fn 
