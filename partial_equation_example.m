% p47.2.1.1
p = @(x)(-1);
q = @(x)(1);
f = @(x)(-x);
breaks = [0,1,2]; k = 3;
[coefM, ppM] = solvePartialEquation(p,q,f,breaks,k,false);
% ppM is in [0,1]
n = size(ppM,1); % n intervals
interval_polys = zeros(n,k);
for i=1:n
    a = breaks(i);
    b = breaks(i+1);
    start = (i-1)*k-i+2;
    tmp_coef = coefM(start:start+k-1);
    tmp_ppM = squeeze(ppM(i,:,:));
    tmp_rep = repmat(tmp_coef,1,length(tmp_coef));
    new_ppM = tmp_ppM.*tmp_rep;
    interval_polys(i,:) = sum(new_ppM,1);
end
polymath = mkpp(breaks, interval_polys);
