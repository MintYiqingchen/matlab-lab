function [U,TR] = FMV(funcf, dgm, kind)
% - Laplace(u) = f(x,y)
% @funcf: function handle
% @dgm: output of decsg, a Decomposed Geometry Matrix
% @kind: border condition, cell array {'essential',alpha} or {'natural', gamma, k}
% return
%   U: value on trangulation potions
%   TR: a triangulation class
condition = kind{1}; % char matrix
fprintf('%s condition\n', condition);
% triangulation
[p,e,t] = initmesh(dgm);
tmp = t(1:3,:)';
TR = triangulation(tmp,p');
ccenters = circumcenter(TR);

% Matrix
leftS = zeros(size(p,2));
rightF = zeros(1,size(p,2));
% pre-calculation
vertexBelongInfos = vertexAttachments(TR);
BorderPoints = unique(e(1:2,:));
for i=1:size(p,2) % for every point
    % relative triangulars
    neiTriIds = vertexBelongInfos{i,:};
    neiCcenters = ccenters(neiTriIds,:);
    % sort
    neiTriIds = clockwiseTIdxs(p(:,i), neiTriIds, neiCcenters);
    % border point and inner point
    isborder = any(BorderPoints==i);
    if isborder && length(neiTriIds)>2
        tmpj = [];
        for j=1:length(neiTriIds) % first boundery triangular
            tmp = TR.ConnectivityList(neiTriIds(j),:);
            if length(intersect(tmp, BorderPoints))>1
                tmpj = [tmpj j];
            end
        end
        if tmpj(1)+1==tmpj(2)
            neiTriIds = [neiTriIds(tmpj+1:end) neiTriIds(1:tmpj)];
        end
    end
    
    [unitS, unitF, pids] = getUnitMatrix(funcf, i,TR, ccenters, neiTriIds ,isborder, kind);
    
    % place unitS and rightF
    rightF(i) = unitF;
    leftS(i,pids) = unitS;
    leftS(i,i)=-sum(unitS);
end
if condition(1)=='e'
    innerpids = setdiff(1:size(p,2), BorderPoints);
    leftS(:,BorderPoints)=[];
    leftS(BorderPoints,:)=[];
    rightF(BorderPoints)=[];
    tmpU = leftS\rightF';
    U = zeros(size(p,2),1);
    U(innerpids)=tmpU;
    U(BorderPoints) = kind{2};
else
    U = leftS\rightF';
end

end