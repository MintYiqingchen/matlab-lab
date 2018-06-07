function [ matrixU, code, Coor, Adj ] = rectangleFiniteElement( func, x_border, y_border, n, m )
%矩形剖分有限元求解poisson方程
%   @func: -Lapician(u)=f, function handle
%   x_border, y_border: [a,b]*[c,d] 2-d region
%   n: number of points along x-axis
% make something for plot
Coor = zeros(n*m,2);
Adj = eye(m*n);
% something for equation
delta_x = (x_border(2)-x_border(1))/(n-1);
delta_y = (y_border(2)-y_border(1))/(m-1);
code=reshape(1:n*m, m, n);
stiffM = zeros(m*n, n*m);
rightVector=zeros(n*m,1);
for i=1:m % y-axis
    for j=1:n % x-axis
        row = code(i,j);
        neighbor = getRecNeighborPoint(i,j);
        neighbor = [neighbor;neighbor(1:2,:)];
        p1=[x_border(1)+delta_x*(j-1), y_border(2)-delta_y*(i-1)];
        Coor(row,:)=p1;
        % record for rectangle location: 1:left down 2:right down 3:right
        % up 4: left up
        %direction = 0;
        for k=1:2:8 % for every rectangle
            %direction = direction+1; % change direction
            N=neighbor(k:k+2,:);
            if ~( all(all(N>0)) && all(N(:,1)<m+1) && all(N(:,2)<n+1))
                continue;
            end
            p2 = [x_border(1)+delta_x*(N(1,2)-1), y_border(2)-delta_y*(N(1,1)-1)];
            p3 = [x_border(1)+delta_x*(N(2,2)-1), y_border(2)-delta_y*(N(2,1)-1)];
            p4 = [x_border(1)+delta_x*(N(3,2)-1), y_border(2)-delta_y*(N(3,1)-1)];
            [M,V] = getRecUnitStiff(func, p1,p2,p3,p4);
            % put into stiffness matrix
            ks = [row
                code(N(1,1), N(1,2))
                code(N(2,1), N(2,2))
                code(N(3,1), N(3,2))];
            for r=1:4
                if r==4
                    Adj(ks(r),ks(1))=1;
                    Adj(ks(1), ks(r))=1;
                else
                    Adj(ks(r),ks(r+1))=1;
                    Adj(ks(r+1),ks(r))=1;
                end
                rr = ks(r);
                rightVector(rr) = rightVector(rr)+V(r);
                for c=1:4
                    cc = ks(c);
                    stiffM(rr,cc)=stiffM(rr,cc)+M(r,c);
                end
            end
        end
    end
end
% delete row and column of border point
border_code=[code(1,:),code(end,:),code(2:end-1,1)',code(2:end-1,end)'];
stiffM(:,border_code)=[];
stiffM(border_code,:)=[];
rightVector(border_code)=[];
innerU=stiffM\rightVector;
matrixU=zeros(m,n);
count=1;
% put into a straightforward matrix
for j=2:n-1
    for i=2:m-1
        matrixU(i,j)=innerU(count);
        count = count+1;
    end
end
end

