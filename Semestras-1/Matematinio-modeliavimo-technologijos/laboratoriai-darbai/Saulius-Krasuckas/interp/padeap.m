function [num,den,t] = padeap(f,xo,M,N,xmin,xmax)
%Input : f = function to be approximated around xo in [xmin, xmax]
%Output: num = numerator coeffs of Pade approximation of degree M
% den = denominator coeffs of Pade approximation of degree N
%Tylor series coefficients
a(1) = feval(f,xo);
h = .01; tmp = 1;
for i = 1:M + N
    tmp = tmp*i*h; %i!h^i
    dix = difapx(i,[-i i])*feval(f,xo+[-i:i]*h)'; %derivative(Section 5.3)
    a(i + 1) = dix/tmp; %Taylor series coefficient
end
for m = 1:N
    n = 1:N; A(m,n) = a(M + 1 + m - n);
    b(m) = -a(M + 1 + m);
end
d = A\b'; %Eq.(3.4.4b)
for m = 1: M + 1
    mm = min(m - 1,N);
    q(m) = a(m:-1:m - mm)*[1; d(1:mm)]; %Eq.(3.4.4a)
end
num = q(M + 1:-1:1)/d(N); den = [d(N:-1:1)' 1]/d(N); %descending order

t=a(M + N + 1:-1:1);

function [c,err,eoh,A,b] = difapx(N,points)
%difapx.m to get the difference approximation for the Nth derivative
l = max(points);
L = abs(points(1)-points(2))+ 1;
if L < N + 1, error('More points are needed!'); end
for n = 1: L
    A(1,n) = 1;
    for m = 2:L + 2, A(m,n) = A(m - 1,n)*l/(m - 1); end %Eq.(5.3.5)
    l = l-1;
end
b = zeros(L,1); b(N + 1) = 1;
c =(A(1:L,:)\b)'; %coefficients of difference approximation formula
err = A(L + 1,:)*c'; eoh = L-N; %coefficient & order of error term
if abs(err) < eps, err = A(L + 2,:)*c'; eoh = L - N + 1; end
if points(1) < points(2), c = fliplr(c); end

