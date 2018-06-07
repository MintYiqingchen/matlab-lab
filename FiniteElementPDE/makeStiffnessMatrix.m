function resM = makeStiffnessMatrix(p,q, bases, a, b)
% p, q function: -pu''+qu
% bases; [[Double]] bases on [0,1]
% [a,b]
% return [[Double]] k*k
nrow=size(bases, 1);
resM = zeros(nrow, nrow);
affine = @(x,a,b)((x-a)./(b-a));
for i=1:nrow
    pp_i = mkpp([0,1],bases(i,:));
    pp_di = mkpp([0,1],polyder(bases(i,:)));
    for j=1:nrow
        pp_j = mkpp([0,1],bases(j,:));
        pp_dj = mkpp([0,1],polyder(bases(j,:)));
        tmpf = @(x)(p(x).*ppval(pp_di,affine(x,a,b)).*ppval(pp_dj,affine(x,a,b))+q(x).*ppval(pp_i,affine(x,a,b)).*ppval(pp_j,affine(x,a,b)));
        resM(i,j)=integral(tmpf, a, b);
    end
end
end
