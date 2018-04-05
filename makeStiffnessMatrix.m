function resM = makeStiffnessMatrix(p,q, bases, a, b)
% p, q function: -pu''+qu
% bases; [[Double]] bases on [0,1]
% [a,b]
% return [[Double]] k*k
nrow=size(bases, 1);
resM = zeros(nrow, nrow);
for i=1:nrow
    pp_i = mkpp([a,b],bases(i,:));
    pp_di = mkpp([a,b],polyder(bases(i,:)));
    for j=1:nrow
        pp_j = mkpp([a,b],bases(j,:));
        pp_dj = mkpp([a,b],polyder(bases(j,:)));
        tmpf = @(x)(p(x).*ppval(pp_di,x).*ppval(pp_dj,x)+q(x).*ppval(pp_i,x).*ppval(pp_j,x));
        resM(i,j)=integral(tmpf, a, b);
    end
end
end
