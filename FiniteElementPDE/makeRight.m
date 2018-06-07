function res=makeRight(f, bases, a, b)
% f: a function
% bases: a bases between [0,1]
% [a,b] : interval
[nrow,~] = size(bases);
res = zeros(nrow,1);
for i=1:nrow
    pp = mkpp([0,1],bases(i,:));
    tmpf = @(x)(f(x).*ppval(pp,(x-a)./(b-a))); % affine transformation
    res(i) = integral(tmpf,a,b);
end
end
    