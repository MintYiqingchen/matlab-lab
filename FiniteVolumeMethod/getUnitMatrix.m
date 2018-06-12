function [ unitS, F, pids ] = getUnitMatrix(func, i,TR, ccenters, neiTriIds ,isborder, kind)
% func: function handler
% i: p0's index in Tr.Points
% ccenters: all circumcenters for TR.ConnectivityList
% TR: triangulation class
% neiTriIds: related row index for TR.ConnectivityList
% isborder: bool. if p0 is on boundery
% @kind: border condition, cell array {'essential',alpha} or {'natural', gamma, k}
unitS = zeros(1,...
    length(unique(TR.ConnectivityList(neiTriIds,:))));
pids = ones(1,length(unitS));
unitF = zeros(1,length(neiTriIds));

p0 = TR.Points(i,:);
if ~isborder
    neiTriIds = [neiTriIds neiTriIds(1)];
end

% not boundry triangular
pids(end)=i;
for j=1:length(neiTriIds)-1
    % get idp1
    t = TR.ConnectivityList(neiTriIds(j),:);
    tmp = find(t==i); % p0
    % p1 is the next point
    if tmp==3
        tmp=1;
    else
        tmp = tmp+1;
    end
    idp1 = t(tmp);
    
    % calculate S(idp1)
    q12 = ccenters(neiTriIds(j:j+1),:);
    normq = sqrt(sum( (q12(1,:)-q12(2,:)).^2) );
    p1 = TR.Points(idp1,:);
    normp = sqrt(sum((p1-p0).^2));
    % place value to unitS
    unitS(j) = -normq./normp;
    pids(j) = idp1;
    
    % calculate F(j)
    unitF(j) = rightIntegral(func, [p0; q12]);
end
% boundery triangular
if isborder && length(kind)==3
    borderScript
end
F = sum(unitF);
end

