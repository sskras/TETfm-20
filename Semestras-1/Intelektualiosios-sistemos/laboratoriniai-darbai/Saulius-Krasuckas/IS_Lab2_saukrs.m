clc;

% Aproksimavimo intervalas:
x = 0.1:1/22:1;
fprintf("x:"); disp(x);

% Aproksimuojamoji funkcija (tikrosios vertės):
d = 5*sin(8*x) + 4*cos(16*x + pi/3);
fprintf("d:"); disp(d);

plot(x, d, 'kx'); grid;

% Pasirenku naudoti 4 neuronų paslėptąjį sl.

% Pradinės koeficientų reikšmės atsitiktinės:
w1_11_n0 = rand(1);  b1_1_n0  = rand(1);

% Skaičiuoju tinklo atsaką,

% pirmo neurono įėjimas:

v1(1) = x(1) * w1_11_n0 + b1_1_n0;

fprintf("Pabaiga.\n");
