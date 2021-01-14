%Classification using perceptron

    % Deja, visų ankstesnių mano pakeitimų istorija (2020-10-21 ... 2020-12-07)
    % šiam failui buvo MATLAB Online sistemos sunaikinti automatiškai (po 30 d.)
    %
    % For details see MathWorks Inc Case # 04683547: Failure to access previous versions of my code in MATLAB Online
    % https://servicerequest.mathworks.com/mysr/cp_case_detail1?cc=se&id=5003q00001N1Uhc

clc;

%Reading apple images
A1=imread('apple_04.jpg');
A2=imread('apple_05.jpg');
A3=imread('apple_06.jpg');
A4=imread('apple_07.jpg');
A5=imread('apple_11.jpg');
A6=imread('apple_12.jpg');
A7=imread('apple_13.jpg');
A8=imread('apple_17.jpg');
A9=imread('apple_19.jpg');

%Reading pears images
P1=imread('pear_01.jpg');
P2=imread('pear_02.jpg');
P3=imread('pear_03.jpg');
P4=imread('pear_09.jpg');

%Calculate for each image, colour and roundness
%For Apples
%1st apple image(A1)
hsv_value_A1=spalva_color(A1); %color
metric_A1=apvalumas_roundness(A1); %roundness
%2nd apple image(A2)
hsv_value_A2=spalva_color(A2); %color
metric_A2=apvalumas_roundness(A2); %roundness
%3rd apple image(A3)
hsv_value_A3=spalva_color(A3); %color
metric_A3=apvalumas_roundness(A3); %roundness
%4th apple image(A4)
hsv_value_A4=spalva_color(A4); %color
metric_A4=apvalumas_roundness(A4); %roundness
%5th apple image(A5)
hsv_value_A5=spalva_color(A5); %color
metric_A5=apvalumas_roundness(A5); %roundness
%6th apple image(A6)
hsv_value_A6=spalva_color(A6); %color
metric_A6=apvalumas_roundness(A6); %roundness
%7th apple image(A7)
hsv_value_A7=spalva_color(A7); %color
metric_A7=apvalumas_roundness(A7); %roundness
%8th apple image(A8)
hsv_value_A8=spalva_color(A8); %color
metric_A8=apvalumas_roundness(A8); %roundness
%9th apple image(A9)
hsv_value_A9=spalva_color(A9); %color
metric_A9=apvalumas_roundness(A9); %roundness

%For Pears
%1st pear image(P1)
hsv_value_P1=spalva_color(P1); %color
metric_P1=apvalumas_roundness(P1); %roundness
%2nd pear image(P2)
hsv_value_P2=spalva_color(P2); %color
metric_P2=apvalumas_roundness(P2); %roundness
%3rd pear image(P3)
hsv_value_P3=spalva_color(P3); %color
metric_P3=apvalumas_roundness(P3); %roundness
%2nd pear image(P4)
hsv_value_P4=spalva_color(P4); %color
metric_P4=apvalumas_roundness(P4); %roundness

%selecting features(color, roundness, 3 apples and 2 pears)
%A1,A2,A3,P1,P2
%building matrix 2x5
x1=[hsv_value_A1 hsv_value_A2 hsv_value_A3 hsv_value_P1 hsv_value_P2];
x2=[   metric_A1    metric_A2    metric_A3    metric_P1    metric_P2];
% estimated features are stored in matrix P:
P=[x1; x2];

%Desired output vector
T=[1;1;1;-1;-1]; % <- ČIA ANKSČIAU BUVO KLAIDA!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

%% train single perceptron with two inputs and one output

% generate random initial values of w1, w2 and b
w1 = randn(1);
w2 = randn(1);
b  = randn(1);

% calculate weighted sum with randomly generated parameters

%v1 = <...>; % write your code here
v1 = x1(1) * w1 + x2(1) * w2 + b;

% calculate current output of the perceptron
if v1 > 0
	y1 = 1;
else
	y1 = -1;
end
% calculate the error
e1 = T(1) - y1;

% repeat the same for the rest 4 inputs x1 and x2
% calculate wieghted sum with randomly generated parameters

% v2 = <...> ; % write your code here
v2 = x1(2) * w1 + x2(2) * w2 + b;

% calculate current output of the perceptron
if v2 > 0
	y2 = 1;
else
	y2 = -1;
end
% calculate the error
e2 = T(2) - y2;

v3 = x1(3) * w1 + x2(3) * w2 + b;
%
if v3 > 0
	y3 = 1;
else
	y3 = -1;
end
%
e3 = T(3) - y3;

v4 = x1(4) * w1 + x2(4) * w2 + b;
%
if v4 > 0
	y4 = 1;
else
	y4 = -1;
end
%
e4 = T(4) - y4;

v5 = x1(5) * w1 + x2(5) * w2 + b;
%
if v5 > 0
	y5 = 1;
else
	y5 = -1;
end
%
e5 = T(5) - y5;

% calculate the total error for these 5 inputs
e = abs(e1) + abs(e2) + abs(e3) + abs(e4) + abs(e5);

% lempinis:
n = 0.43;
% kiek žingsnių:
i = 0;

% write training algorithm
while e ~= 0 % executes while the total error is not 0

    i = i + 1;
    fprintf("Žingsnis %-5d: klaida = %f\n", i, e);

    % here should be your code of parameter update:
    %   calculate output for current example
    %
    %   calculate error for current example
    %
    %   update parameters using current inputs ant current error

    % 	w1 =
    w1 = w1 + n*e1*x1(1);
    w1 = w1 + n*e2*x1(2);
    w1 = w1 + n*e3*x1(3);
    w1 = w1 + n*e4*x1(4);
    w1 = w1 + n*e5*x1(5);

    %   w2 =
    w2 = w2 + n*e1*x2(1);
    w2 = w2 + n*e2*x2(2);
    w2 = w2 + n*e3*x2(3);
    w2 = w2 + n*e4*x2(4);
    w2 = w2 + n*e5*x2(5);

    %   b =
    b = b + n*e1;
    b = b + n*e2;
    b = b + n*e3;
    b = b + n*e4;
    b = b + n*e5;

    %   Test how good are updated parameters (weights) on all examples used for training:
    %   calculate outputs and errors for all 5 examples using current values of the parameter set {w1, w2, b}
    %   calculate 'v1', 'v2', 'v3',... 'v5'
    %
    v1 = x1(1) * w1 + x2(1) * w2 + b;
    v2 = x1(2) * w1 + x2(2) * w2 + b;
    v3 = x1(3) * w1 + x2(3) * w2 + b;
    v4 = x1(4) * w1 + x2(4) * w2 + b;
    v5 = x1(5) * w1 + x2(5) * w2 + b;

    %   calculate 'y1', ..., 'y5'
    %
    y1 = sign(v1);
    y2 = sign(v2);
    y3 = sign(v3);
    y4 = sign(v4);
    y5 = sign(v5);

    %   calculate 'e1', ... 'e5'
    %
    e1 = T(1) - y1;
    e2 = T(2) - y2;
    e3 = T(3) - y3;
    e4 = T(4) - y4;
    e5 = T(5) - y5;

    % calculate the total error for these 5 inputs
    e = abs(e1) + abs(e2) + abs(e3) + abs(e4) + abs(e5);
end

fprintf("Po šio žingsnio klaida = %f\n\n", e);
fprintf("Žingsnių: %d, n=%f, w1=%f, w2=%f, b=%f\n\n", i, n, w1, w2, b);

% test set: A1,A2,A3,P1,P2
% building test matrix 2x7
x1_test = [hsv_value_P3 hsv_value_P4 hsv_value_A5 hsv_value_A6 hsv_value_A7 hsv_value_A8 hsv_value_A9];
x2_test = [   metric_P3    metric_P4    metric_A5    metric_A6    metric_A7    metric_A8    metric_A9];

% estimated test features are stored in test matrix P:
P_test = [x1_test; x2_test];

% neuron values for the test input:
v_test = [ 0; 0; 0; 0; 0; 0; 0];

% activation-fn values for the test input:
y_test = [ 0; 0; 0; 0; 0; 0; 0];

% expected output vector:
T_test = [-1;-1; 1; 1; 1; 1; 1];

% produced errors vector for test input:
e_test = [ 0; 0; 0; 0; 0; 0; 0];

    v_test(1) = x1_test(1) * w1 + x2_test(1) * w2 + b;
    v_test(2) = x1_test(2) * w1 + x2_test(2) * w2 + b;
    v_test(3) = x1_test(3) * w1 + x2_test(3) * w2 + b;
    v_test(4) = x1_test(4) * w1 + x2_test(4) * w2 + b;
    v_test(5) = x1_test(5) * w1 + x2_test(5) * w2 + b;
    v_test(6) = x1_test(6) * w1 + x2_test(6) * w2 + b;
    v_test(7) = x1_test(7) * w1 + x2_test(7) * w2 + b;

    y_test(1) = sign(v_test(1));
    y_test(2) = sign(v_test(2));
    y_test(3) = sign(v_test(3));
    y_test(4) = sign(v_test(4));
    y_test(5) = sign(v_test(5));
    y_test(6) = sign(v_test(6));
    y_test(7) = sign(v_test(7));

    e_test(1) = T_test(1) - y_test(1);
    e_test(2) = T_test(2) - y_test(2);
    e_test(3) = T_test(3) - y_test(3);
    e_test(4) = T_test(4) - y_test(4);
    e_test(5) = T_test(5) - y_test(5);
    e_test(6) = T_test(6) - y_test(6);
    e_test(7) = T_test(7) - y_test(7);

fprintf("Testinė matrica:\n");
disp(P_test);
fprintf("(HSV-color, roundness)\n\n");

fprintf("Laukiamo rezultato vektorius:\n");
disp(T_test);

fprintf("Gautojo rezultato vektorius:\n");
disp(y_test);

fprintf("Gautojo rezultato klaidos:\n");
disp(e_test);

fprintf("\n");

%% pagalbinė funkcija

function res = tern(cond, a, b)
   if cond
       res = a;
   else
       res = b;
   end
end
