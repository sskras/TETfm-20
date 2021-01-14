clc;

% Aproksimavimo intervalas:
x = 0.1:1/22:1;
fprintf("x:\n"); disp(x);

% Aproksimuojamoji funkcija (tikrosios vertės):
d = 5*sin(8*x) + 4*cos(16*x + pi/3);
fprintf("d:\n"); disp(d);

fprintf("Pabaiga.\n");
