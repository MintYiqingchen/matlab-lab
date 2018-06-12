function res = rightIntegral(func, P)
% func: a function handler
% P:3*2 Triangular Pointes
% return: 2-d integral in the triangular
[xa,minIdx] = min(P(:,1));
[xb,maxIdx] = max(P(:,1));
midIdx = 6-minIdx-maxIdx;
% vertical
if sum(P(:,1)==xa)==2 % min-mid vertical
    % line min-max
    k2 = (P(minIdx,2)-P(maxIdx,2))./(P(minIdx,1)-P(maxIdx,1));
    b2 = P(minIdx,2)-k2.*P(minIdx,1);
    f2 = @(x)(k2.*x+b2);
    % line mid-max
    k3 = (P(maxIdx,2)-P(midIdx,2))./(P(maxIdx,1)-P(midIdx,1));
    b3 = P(midIdx,2)-k3.*P(midIdx,1);
    f3 = @(x)(k3.*x+b3);
    if P(minIdx, 2)<P(midIdx, 2)
        res = integral2(func, xa, xb, f2,f3);
    else
        res = integral2(func, xa,xb, f3, f2);
    end
    return;
elseif sum(P(:,1)==xb)==2 % max-mid vertical
    % line min-mid
    k1 = (P(minIdx,2)-P(midIdx,2))./(P(minIdx,1)-P(midIdx,1));
    b1 = P(minIdx,2)-k1.*P(minIdx,1);
    f1 = @(x)(k1.*x+b1);
    % line min-max
    k2 = (P(minIdx,2)-P(maxIdx,2))./(P(minIdx,1)-P(maxIdx,1));
    b2 = P(minIdx,2)-k2.*P(minIdx,1);
    f2 = @(x)(k2.*x+b2);
    if P(midIdx, 2)<P(maxIdx, 2)
        res = integral2(func, xa, xb, f1,f2);
    else
        res = integral2(func, xa,xb, f2, f1);
    end
    return;
end
% line min-mid
k1 = (P(minIdx,2)-P(midIdx,2))./(P(minIdx,1)-P(midIdx,1));
b1 = P(minIdx,2)-k1.*P(minIdx,1);
f1 = @(x)(k1.*x+b1);
% line min-max
k2 = (P(minIdx,2)-P(maxIdx,2))./(P(minIdx,1)-P(maxIdx,1));
b2 = P(minIdx,2)-k2.*P(minIdx,1);
f2 = @(x)(k2.*x+b2);
% line mid-max
k3 = (P(maxIdx,2)-P(midIdx,2))./(P(maxIdx,1)-P(midIdx,1));
b3 = P(midIdx,2)-k3.*P(midIdx,1);
f3 = @(x)(k3.*x+b3);
if f1(P(midIdx,1))<f2(P(midIdx,1)) % downward
    F1=integral2(func,xa,P(midIdx,1),f1,f2);
    F2=integral2(func,P(midIdx,1), xb, f3, f2);
else % upward
    F1=integral2(func,xa,P(midIdx,1),f2,f1);
    F2=integral2(func,P(midIdx,1), xb, f2, f3);
end
res = F1+F2;
end

