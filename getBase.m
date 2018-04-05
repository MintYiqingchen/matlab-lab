function res=getBase(k)
% get k order base between [0,1]
% k: piecewise order x^(k-1)
% return [[Double]] k*k base coefficient
xxs = linspace(0,1,k);
res = zeros(k,k);
for i=1:k % i-th base
    A = zeros(k,k);
    A(:,k) = ones(k,1);
    b = zeros(k,1);
    b(i)=1;
    for j=1:k % j-th row
        for m=1:k-1 % m-th col
            A(j,m)=xxs(j)^m;
        end
    end
    res(i,:)=A\b;
end
end