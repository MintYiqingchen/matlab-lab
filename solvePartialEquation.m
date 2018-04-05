% solve Lu=-(pu')'+qu = f
function [res_coefs, res_pps]=solvePartialEquation(p, q, f,ux, k, pb)
% p, q, f: function
% ux:[Double] n+1 range 
% k: piecewise order
% pb: if True u'(b)=0 else u(b)=0
% return [[Double]] coeficients for n-th interval, [pps] bases for n-th interval
n=length(ux)-1;
res_pps = zeros(n,k,k);
full_stiffM = zeros(n*k-n+1);
full_b = zeros(n*k-n+1,1);
pps = getBase(k);
for i=2:length(ux)
    % get polynomial bases of unit i
    res_pps(i-1,:,:)=pps;
    b = makeRight(f,pps,ux(i-1), ux(i));
    A = makeStiffnessMatrix(p,q,pps,ux(i-1), ux(i));
    count = i-1;
    start = (count-1).*k-count+2;
    full_stiffM(start:start+k-1,start:start+k-1) = full_stiffM(start:start+k-1,start:start+k-1)+A;
    full_b(start:start+k-1) = full_b(start:start+k-1)+b;
end

assert(~(k==2 && n==1 && ~pb), 'When u(b)=0, k should be greater than 2');
if pb
    full_stiffM = full_stiffM(2:n*k-n+1,2:n*k-n+1);
    full_b = full_b(2:n*k-n+1);
    res_coefs = full_stiffM\full_b;
    res_coefs = [0;res_coefs];
else
    full_stiffM = full_stiffM(2:n*k-n,2:n*k-n);
    full_b = full_b(2:n*k-n);
    res_coefs = full_stiffM\full_b;
    res_coefs = [0;res_coefs;0];
end
end
