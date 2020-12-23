%Classification using perceptron

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
x1=[hsv_value_A1 hsv_value_A2 hsv_value_A3 hsv_value_P1 hsv_value_P2 hsv_value_A4 hsv_value_A5 hsv_value_A6 hsv_value_A7 hsv_value_A8 hsv_value_A9 hsv_value_P3 hsv_value_P4];
x2=[metric_A1 metric_A2 metric_A3 metric_P1 metric_P2 metric_A4 metric_A5 metric_A6 metric_A7 metric_A8 metric_A9 metric_P3 metric_P4];
% estimated features are stored in matrix P:
P=[x1;x2];

%Desired output vector
T=[1;1;1;-1;-1;1;1;1;1;1;1;-1;-1]; 

%% train single perceptron with two inputs and one output

% generate random initial values of w1, w2 and b
w1 = randn(1);
w2 = randn(1);
b = randn(1);

% calculate weighted sum with randomly generated parameters
v1 = P(1,1)*w1 + P(2,1)*w2 + b;
% calculate current output of the perceptron 
if v1 > 0
	y = 1;
else
	y = -1;
end
% calculate the error
e1 = T(1) - y;

% repeat the same for the rest 4 inputs x1 and x2
% calculate wieghted sum with randomly generated parameters
v2 = P(1,2)*w1 + P(2,2)*w2 + b;
% calculate current output of the perceptron 
if v2 > 0
	y = 1;
else
	y = -1;
end
% calculate the error
e2 = T(2) - y;

% <...> write the code for another 3 inputs

%input 3
% calculate wieghted sum with randomly generated parameters
v3 = P(1,3)*w1 + P(2,3)*w2 + b;
% calculate current output of the perceptron 
if v3 > 0
	y = 1;
else
	y = -1;
end
% calculate the error
e3 = T(3) - y;

%input 4
% calculate wieghted sum with randomly generated parameters
v4 = P(1,4)*w1 + P(2,4)*w2 + b;
% calculate current output of the perceptron 
if v4 > 0
	y = 1;
else
	y = -1;
end
% calculate the error
e4 = T(4) - y;

%input 5
% calculate wieghted sum with randomly generated parameters
v5 = P(1,5)*w1 + P(2,5)*w2 + b;
% calculate current output of the perceptron 
if v5 > 0
	y = 1;
else
	y = -1;
end
% calculate the error
e5 = T(5) - y;

% calculate the total error for these 9 inputs 
e = abs(e1) + abs(e2) + abs(e3) + abs(e4) + abs(e5);
%error zingsnis
n = 0.25;
% write training algorithm
ciklai = 0;
while e ~= 0 % executes while the total error is not 0
% here should be your code of parameter update

%   calculate output for example 1
    v1 = P(1,1)*w1 + P(2,1)*w2 + b;
%   calculate error for current example
    if v1 > 0
        y = 1;
    else
        y = -1;
    end
    e1 = T(1) - y;
%   update parameters using current inputs ant current error
    w1 = w1 + n * e1 * P(1,1);
    w2 = w2 + n * e1 * P(2,1);
    b = b + n * e1;
    
%   calculate output for example 2
    v2 = P(1,2)*w1 + P(2,2)*w2 + b;
%   calculate error for current example
    if v2 > 0
        y = 1;
    else
        y = -1;
    end
    e2 = T(2) - y;
%   update parameters using current inputs ant current error
    w1 = w1 + n * e2 * P(1,2);
    w2 = w2 + n * e2 * P(2,2);
    b = b + n * e2;
    
%   calculate output for example 3
    v3 = P(1,3)*w1 + P(2,3)*w2 + b;    
%   calculate error for current example
    if v3 > 0
        y = 1;
    else
        y = -1;
    end
    e3 = T(3) - y;
%   update parameters using current inputs ant current error
    w1 = w1 + n * e3 * P(1,3);
    w2 = w2 + n * e3 * P(2,3);
    b = b + n * e3;
    
%   calculate output for example 4
    v4 = P(1,4)*w1 + P(2,4)*w2 + b;
%   calculate error for current example
    if v4 > 0
        y = 1;
    else
        y = -1;
    end
    e4 = T(4) - y;
%   update parameters using current inputs ant current error
    w1 = w1 + n * e4 * P(1,4);
    w2 = w2 + n * e4 * P(2,4);
    b = b + n * e4;
    
%   calculate output for example 5
    v5 = P(1,5)*w1 + P(2,5)*w2 + b;
%   calculate error for current example
    if v5 > 0
        y = 1;
    else
        y = -1;
    end
    e5 = T(5) - y;
%   update parameters using current inputs ant current error
    w1 = w1 + n * e5 * P(1,5);
    w2 = w2 + n * e5 * P(2,5);
    b = b + n * e5;

	% calculate the total error for these 5 inputs 
	e = abs(e1) + abs(e2) + abs(e3) + abs(e4) + abs(e5);
%temp e = 0 for test
    ciklai = ciklai +1;
end
%   Test how good are updated parameters (weights) on all examples used for training
%   calculate outputs and errors for all 5 examples using current values of the parameter set {w1, w2, b}
%   calculate 'v1', 'v2', 'v3',... 'v5'
    v1 = P(1,1)*w1 + P(2,1)*w2 + b;
    v2 = P(1,2)*w1 + P(2,2)*w2 + b;
    v3 = P(1,3)*w1 + P(2,3)*w2 + b;
    v4 = P(1,4)*w1 + P(2,4)*w2 + b;
    v5 = P(1,5)*w1 + P(2,5)*w2 + b;    
    v6 = P(1,6)*w1 + P(2,6)*w2 + b;
    v7 = P(1,7)*w1 + P(2,7)*w2 + b;
    v8 = P(1,8)*w1 + P(2,8)*w2 + b;
    v9 = P(1,9)*w1 + P(2,9)*w2 + b;
    v10 = P(1,10)*w1 + P(2,10)*w2 + b;
    v11 = P(1,11)*w1 + P(2,11)*w2 + b;
    v12 = P(1,12)*w1 + P(2,12)*w2 + b;
    v13 = P(1,13)*w1 + P(2,13)*w2 + b;

%   calculate 'y1', ..., 'y5'
    if v1 > 0
        y1 = 1;
    else
        y1 = -1;
    end
    
    if v2 > 0
        y2 = 1;
    else
        y2 = -1;
    end
    
    if v3 > 0
        y3 = 1;
    else
        y3 = -1;
    end
    
    if v4 > 0
        y4 = 1;
    else
        y4 = -1;
    end
    
    if v5 > 0
        y5 = 1;
    else
        y5 = -1;
    end
    
    if v6 > 0
        y6 = 1;
    else
        y6 = -1;
    end
    
    if v7 > 0
        y7 = 1;
    else
        y7 = -1;
    end    
    
    if v8 > 0
        y8 = 1;
    else
        y8 = -1;
    end
    
    if v9 > 0
        y9 = 1;
    else
        y9 = -1;
    end
    
    if v10 > 0
        y10 = 1;
    else
        y10 = -1;
    end
    
    if v11 > 0
        y11 = 1;
    else
        y11 = -1;
    end
    
    if v12 > 0
        y12 = 1;
    else
        y12 = -1;
    end
    
    if v13 > 0
        y13 = 1;
    else
        y13 = -1;
    end

%   calculate 'e1', ... 'e9'
    e1 = T(1) - y1;
    e2 = T(2) - y2;
    e3 = T(3) - y3;
    e4 = T(4) - y4;
    e5 = T(5) - y5;
    e6 = T(6) - y6;
    e7 = T(7) - y7;
    e8 = T(8) - y8;
    e9 = T(9) - y9;
    e10 = T(10) - y10;
    e11 = T(11) - y11;
    e12 = T(12) - y12;
    e13 = T(13) - y13;

	% calculate the total error for these 13 inputs 
	e = abs(e1) + abs(e2) + abs(e3) + abs(e4) + abs(e5)+ abs(e6) + abs(e7) + abs(e8) + abs(e9) + abs(e10) + + abs(e11) + abs(e12) + abs(e13);
