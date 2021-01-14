clc;

% Aproksimavimo intervalas:
fprintf("x:\n");
x = 0.1:1/22:1;
disp(x);

% Aproksimuojamoji funkcija (tikrosios vertės):
fprintf("d:\n");
d = 5*sin(8*x) + 4*cos(16*x + pi/3);
disp(d);

fprintf("Pabaiga.\n");
