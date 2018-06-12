function res = calculatePointValue( TR,U,Points )
bestPoint = nearestNeighbor(TR,Points);
% find corresponding triangular
[m,~]=size(Points);
res = zeros(m,1);
for p = 1:m % for every point
    triId = ownerTriangular(TR, Points(p,:), bestPoint(p));
    % === calculate base ===
    pids=TR.ConnectivityList(triId,:);
    P = TR.Points(pids,:); % counterclock-wise
    Us = U(pids);
    P = [ones(3,1) P];
    S_mu2 = det(P);
    % calculate L_{i,j,k}
    val = 0.0;
    x=Points(p,1);y=Points(p,2);
    
    for i=1:3
        u = Us(i);
        if i==1
            p2 = P(2,2:3); p3=P(3,2:3);
        elseif i==2
            p2 = P(3,2:3); p3=P(1,2:3);
        else
            p2 = P(1,2:3); p3=P(2,2:3);
        end
        a = p2(1)*p3(2)-p3(1)*p2(2);
        b = p2(2)-p3(2);
        c = p3(1)-p2(1);
        val = val+(u.*(a+b.*x+c.*y)./S_mu2);
    end
    res(p) = val;
end
end
