clc;

    % žingsnis:
    n = 0.3;

% Aproksimavimo intervalas:
x = 0.1:1/22:1;
fprintf("x:"); disp(x);

% Aproksimuojamoji funkcija (tikrosios vertės):
d = 5*sin(8*x) + 4*cos(16*x + pi/3);
fprintf("d:"); disp(d);

plot(x, d, 'kx'); grid;

% Pasirenku naudoti 4 neuronų paslėptąjį sl.

% Pradines koeficientų reikšmes imu atsitiktines:
w1_11_n0 = rand(1);  b1_1_n0  = rand(1);
w1_21_n0 = rand(1);  b1_2_n0  = rand(1);
w1_31_n0 = rand(1);  b1_3_n0  = rand(1);
w1_41_n0 = rand(1);  b1_4_n0  = rand(1);
w1_51_n0 = rand(1);  b1_5_n0  = rand(1);
w1_61_n0 = rand(1);  b1_6_n0  = rand(1);

w2_11_n0 = rand(1);
w2_12_n0 = rand(1);
w2_13_n0 = rand(1);
w2_14_n0 = rand(1);
w2_15_n0 = rand(1);
w2_16_n0 = rand(1);
b2_1_n0  = rand(1);

% Skaičiuoju tinklo atsaką,
y = zeros(1, length(x));
% ... ir kiekvienos iteracijos klaidas,
e = zeros(1, length(x));

for i=1:length(x)
    % paslėptojo sl. neuronų įėjimai:
    v1 = x(i) * w1_11_n0 + b1_1_n0;
    v2 = x(i) * w1_21_n0 + b1_2_n0;
    v3 = x(i) * w1_31_n0 + b1_3_n0;
    v4 = x(i) * w1_41_n0 + b1_4_n0;
    v5 = x(i) * w1_51_n0 + b1_5_n0;
    v6 = x(i) * w1_61_n0 + b1_6_n0;

    % ... jų išėjimai:
    y1 = tanh(v1);
    y2 = tanh(v2);
    y3 = tanh(v3);
    y4 = tanh(v4);
    y5 = tanh(v5);
    y6 = tanh(v6);

    % iš. sl. neurono išėjimas:
    y(i) = y1 * w2_11_n0 + ...
           y2 * w2_12_n0 + ...
           y3 * w2_13_n0 + ...
           y4 * w2_14_n0 + ...
           y5 * w2_15_n0 + ...
           y6 * w2_16_n0 + ...
                b2_1_n0;

    % iteracijos klaida:
    e(i) = d(i) - y(i);

    % sumatoriaus aktyvavimo funkcija = v;
    % jos išvestinė (pagal v) = 1;

    % imame tikslo funkciją = e^2/2;
    % jos išvestinė (pagal e) = e;

    % išėjimo sl. gradientas:
    delta2 = 1 * e(i);

    % išėjimo sl. koeficientai (tikslinimas):
    w2_11_n1 = w2_11_n0 + n * delta2 * y1;
    w2_12_n1 = w2_12_n0 + n * delta2 * y2;
    w2_13_n1 = w2_13_n0 + n * delta2 * y3;
    w2_14_n1 = w2_14_n0 + n * delta2 * y4;
    w2_15_n1 = w2_15_n0 + n * delta2 * y5;
    w2_16_n1 = w2_16_n0 + n * delta2 * y6;
    b2_1_n1  = b2_1_n0  + n * delta2;

    % paslėptojo sl. gradientai:
        % phi(v)=tanh(v) išvestinė (pagal v) = (1 - y * y);
    delta1_1 = (1 - y1 * y1) * delta2 * w2_11_n0;
    delta1_2 = (1 - y2 * y2) * delta2 * w2_12_n0;
    delta1_3 = (1 - y3 * y3) * delta2 * w2_13_n0;
    delta1_4 = (1 - y4 * y4) * delta2 * w2_14_n0;
    delta1_5 = (1 - y5 * y5) * delta2 * w2_15_n0;
    delta1_6 = (1 - y6 * y6) * delta2 * w2_16_n0;

    % paslėptojo sl. koeficientai (tikslinimas):
    w1_11_n0 = w1_11_n0 + n * delta1_1 * x(i);
    w1_21_n0 = w1_21_n0 + n * delta1_2 * x(i);
    w1_31_n0 = w1_31_n0 + n * delta1_3 * x(i);
    w1_41_n0 = w1_41_n0 + n * delta1_4 * x(i);
    w1_51_n0 = w1_51_n0 + n * delta1_5 * x(i);
    w1_61_n0 = w1_61_n0 + n * delta1_6 * x(i);

    b1_1_n0  = b1_1_n0  + n * delta1_1;
    b1_2_n0  = b1_2_n0  + n * delta1_2;
    b1_3_n0  = b1_3_n0  + n * delta1_3;
    b1_4_n0  = b1_4_n0  + n * delta1_4;
    b1_5_n0  = b1_5_n0  + n * delta1_5;
    b1_6_n0  = b1_6_n0  + n * delta1_6;

    % atnaujintus koeficientus įrašome į senųjų vietą (jau nebeverta saugoti):
    w2_11_n0 = w2_11_n1;
    w2_12_n0 = w2_12_n1;
    w2_13_n0 = w2_13_n1;
    w2_14_n0 = w2_14_n1;
    w2_15_n0 = w2_15_n1;
    w2_16_n0 = w2_16_n1;
    b2_1_n0  = b2_1_n1;

    %% galimai šito nereikės, kadangi gradientų skaičiavimui reikalingos
    %% senosios w-vertės panaudotos prieš jų atnaujinimą
    %% (sugrupavus delta1_* skaičiavimus kartu, aukščiau).
    %% w1_11_n0 = w1_11_n1;
end

fprintf("y:"); disp(y);
fprintf("e:"); disp(e);

% patikrinkime perceptrono veiksnumą:

x(i) = 0.7612; % tada y turėtų būti:
d(i) = 5*sin(8*x(i)) + 4*cos(16*x(i) + pi/3); % 2.198;

for i=1:length(x)
    % paslėptojo sl. neuronų įėjimai:
    v1 = x(i) * w1_11_n0 + b1_1_n0;
    v2 = x(i) * w1_21_n0 + b1_2_n0;
    v3 = x(i) * w1_31_n0 + b1_3_n0;
    v4 = x(i) * w1_41_n0 + b1_4_n0;
    v5 = x(i) * w1_51_n0 + b1_5_n0;
    v6 = x(i) * w1_61_n0 + b1_6_n0;

    % ... jų išėjimai:
    y1 = tanh(v1);
    y2 = tanh(v2);
    y3 = tanh(v3);
    y4 = tanh(v4);
    y5 = tanh(v5);
    y6 = tanh(v6);

    % iš. sl. neurono išėjimas:
    y(i) = y1 * w2_11_n0 + ...
           y2 * w2_12_n0 + ...
           y3 * w2_13_n0 + ...
           y4 * w2_14_n0 + ...
           y5 * w2_15_n0 + ...
           y6 * w2_16_n0 + ...
                b2_1_n0;

    % iteracijos klaida:
    e(i) = d(i) - y(i);
end

plot(x, d, 'kx', x, y, 'o'); grid;

fprintf("x = %f, d = %f, aproksimuotas y = %f, paklaida e = %f.\n", x(i), d(i), y(i), e(i));
%
% Ištaisius grubią klaidą reikalai pagerėjo:
% x = 0.761200, d = 2.198011, aproksimuotas y = 2.259677, paklaida e = -0.061666.

fprintf("Pabaiga.\n");
