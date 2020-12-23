clc;
clear; 
close all;
x = [0.1:1/22:1]; %įėjimas iš 20 skaičių, vektorius X
yOut = (1 + 0.6 * sin(2*pi*x/0.7)) + 0.3 * sin(2*pi*x) / 2; %vienas išėjimas 
plot(x,yOut); 

% generate random initial values of w1, w2 and b
w1 = randn(1);
w2 = randn(1);
b = randn(1);

%is akies parinkti duomenis pagal duota signala
c1 = 0.19;
c2 = 0.9;
r1 = 0.14;
r2 = 0.12;

n = 0.5; %error zingsnis

for mokymas = 1:1000
    for taskasNr = 1:20
        y = (exp(-(x(taskasNr)-c1).^2/(2*r1.^2)))*w1+(exp(-(x(taskasNr)-c2).^2/(2*r2.^2)))*w2+b;
        error = yOut(taskasNr)-y;
        b = b+n*error;
        w1 = w1+n*error*(exp(-(x(taskasNr)-c1).^2/(2*r1.^2)));
        w2 = w2+n*error*(exp(-(x(taskasNr)-c2).^2/(2*r2.^2)));
    end
    mokymas = mokymas+1;
end

yFinal = (exp(-(x-c1).^2/(2*r1.^2)))*w1+(exp(-(x-c2).^2/(2*r2.^2)))*w2+b;

plot(x,yFinal,'blue',x,yOut,'red')