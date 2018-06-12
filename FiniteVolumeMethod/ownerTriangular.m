function tid = ownerTriangular( TR, point, nearestPid)
tids = vertexAttachments(TR,nearestPid);
tids = tids{1};
pids = TR.ConnectivityList(tids,:);
for i = size(pids,1)
    P = TR.Points(pids(i,:),:);
    P1 = [point; P(1:2,:)];
    P2 = [point; P(2:3,:)];
    P3 = [point; P([3 1],:)];
    d1 = [ones(3,1) P1];
    d2 = [ones(3,1) P2];
    d3 = [ones(3,1) P3];
    S = [ones(3,1) P];
    a = (det(d1)+det(d2)+det(d3))./det(S);
    if abs(a-1)<1e-15 
        tid = tids(i);
        return
    end
end
tid=0;
end

