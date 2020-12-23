%2.1 generuojami atsitiktiniai koeficientai
w1_1 = randn(1);
w2_1 = randn(1);
w3_1 = randn(1);
w4_1 = randn(1);
w5_1 = randn(1);

b1_1 = randn(1);
b2_1 = randn(1);
b3_1 = randn(1);
b4_1 = randn(1);
b5_1 = randn(1);

w1_2 = randn(1);
w2_2 = randn(1);
w3_2 = randn(1);
w4_2 = randn(1);
w5_2 = randn(1);

b1_2 = randn(1);

for ciklai = 0:1:100000
for x = 0.1:1/22:1
%1. generuojamas d
d = (1 + 0.6 * sin(2*pi*x/0.7)) + 0.3 * sin(2*pi*x) / 2;

%2.2 skaiciuojami pirmo sluoksnio isejimai
v1_1 = x * w1_1 + b1_1;
v2_1 = x * w2_1 + b2_1;
v3_1 = x * w3_1 + b3_1;
v4_1 = x * w4_1 + b4_1;
v5_1 = x * w5_1 + b5_1;

%2.2.2 pritaikoma aktyvioji funkcija phi
y1_1 = 1/(1 + exp(-v1_1));
y2_1 = 1/(1 + exp(-v2_1));
y3_1 = 1/(1 + exp(-v3_1));
y4_1 = 1/(1 + exp(-v4_1));
y5_1 = 1/(1 + exp(-v5_1));

%2.3 skaiciuojami antro sluoksnio isejimai, y = v
y = y1_1 * w1_2 + y2_1 * w2_2 + y3_1 * w3_2 + y4_1 * w4_2 + y5_1 * w5_2 + b1_2;

%2.4 skaiciuojama klaida, delta_out = e
e = d - y;

%3.1 atnaujinami koeficientai: w = w + n * phi * y, n bet koks 0:1
n = 0.25;
w1_2 = w1_2 + n * e * y1_1;
w2_2 = w2_2 + n * e * y2_1;
w3_2 = w3_2 + n * e * y3_1;
w4_2 = w4_2 + n * e * y4_1;
w5_2 = w5_2 + n * e * y5_1;
b1_2 = b1_2 + n * e;

%3.2 atnaujinami pirmo sluoksnio koeficientai
%delta1 = phi1' * delta_out * W1_2
%phi1' = y1_1(1-y1_1)
delta1 = (y1_1 * (1 - y1_1)) * e * w1_2;
delta2 = (y2_1 * (1 - y2_1)) * e * w2_2;
delta3 = (y3_1 * (1 - y3_1)) * e * w3_2;
delta4 = (y4_1 * (1 - y4_1)) * e * w4_2;
delta5 = (y5_1 * (1 - y5_1)) * e * w5_2;

w1_1 = w1_1 + n * x * delta1;
w2_1 = w2_1 + n * x * delta2;
w3_1 = w3_1 + n * x * delta3;
w4_1 = w4_1 + n * x * delta4;
w5_1 = w5_1 + n * x * delta5;

b1_1 = b1_1 + n * delta1;
b2_1 = b2_1 + n * delta2;
b3_1 = b3_1 + n * delta3;
b4_1 = b4_1 + n * delta4;
b5_1 = b5_1 + n * delta5;

%plot(x,y,'kx')
end
end

yfinal = [];
i = 0;
for x = 0.1:1/22:1
%1. generuojamas d
d = (1 + 0.6 * sin(2*pi*x/0.7)) + 0.3 * sin(2*pi*x) / 2;

%2.2 skaiciuojami pirmo sluoksnio isejimai
v1_1 = x * w1_1 + b1_1;
v2_1 = x * w2_1 + b2_1;
v3_1 = x * w3_1 + b3_1;
v4_1 = x * w4_1 + b4_1;
v5_1 = x * w5_1 + b5_1;

%2.2.2 pritaikoma aktyvioji funkcija phi
y1_1 = 1/(1 + exp(-v1_1));
y2_1 = 1/(1 + exp(-v2_1));
y3_1 = 1/(1 + exp(-v3_1));
y4_1 = 1/(1 + exp(-v4_1));
y5_1 = 1/(1 + exp(-v5_1));

%2.3 skaiciuojami antro sluoksnio isejimai, y = v
i = i + 1;
y = y1_1 * w1_2 + y2_1 * w2_2 + y3_1 * w3_2 + y4_1 * w4_2 + y5_1 * w5_2 + b1_2;
yfinal = [yfinal, y]; 
end

x = 0.1:1/22:1;
d = (1 + 0.6 * sin(2*pi*x/0.7)) + 0.3 * sin(2*pi*x) / 2;
plot ( x, d, 'o', x, yfinal, 'kx')