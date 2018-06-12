% this is private script used in getUnitMatrix(...)
ll = length(neiTriIds);
k = kind{3}; gamma = kind{2};
% first border
center1 = ccenters(neiTriIds(1),:);
t = TR.ConnectivityList(neiTriIds(1),:);
tmp = find(t==i); % p0
% p1 is the next point
if tmp==1
    tmp=3;
else
    tmp = tmp-1;
end
idp1 = t(tmp); pids(ll) = idp1;
p1 = TR.Points(idp1,:);
normp = sqrt(sum((p0-p1).^2));
unitS(ll) = normp.*k./8;
unitS(end) = unitS(end)+normp.*k*3./8;
unitF(ll) = rightIntegral(func, [p0;center1;(p0+p1)./2])+0.5*normp;

% second border
center1 = ccenters(neiTriIds(end),:);
t = TR.ConnectivityList(neiTriIds(end),:);
tmp = find(t==i); % p0
% p1 is the next point
if tmp==3
    tmp=1;
else
    tmp = tmp+1;
end
idp1 = t(tmp); pids(ll+1) = idp1;
p1 = TR.Points(idp1,:);
normp = sqrt(sum((p0-p1).^2));
unitS(ll+1) = normp.*k./8;
unitS(end) = unitS(end)+normp.*k*3./8;
unitF(ll+1) = rightIntegral(func, [p0;center1;(p0+p1)./2])+0.5*normp;