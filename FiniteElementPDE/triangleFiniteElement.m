function [matrixU, code, Coor, Adj] = triangleFiniteElement( func, x_border, y_border, n, m )
%三角剖分有限元求解poisson方程
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
        neighbor = getTriNeighborPoint(i,j);
        neighbor = [neighbor; neighbor(1,:)]; % loop pad
        p1=[x_border(1)+delta_x*(j-1), y_border(2)-delta_y*(i-1)];
        Coor(row,:)=p1;
        for k=1:6 % handle every triangle around (i,j)
            p2=[x_border(1)+delta_x*(neighbor(k,2)-1), y_border(2)-delta_y*(neighbor(k,1)-1)];
            p3=[x_border(1)+delta_x*(neighbor(k+1,2)-1), y_border(2)-delta_y*(neighbor(k+1,1)-1)];
            if neighbor(k,2)==0 || neighbor(k+1,2)==0 || neighbor(k,2)==n+1 || neighbor(k+1,2)==n+1 ||...
                neighbor(k,1)==0 || neighbor(k+1,1)==0 || neighbor(k,1)==m+1 || neighbor(k+1,1)==m+1
                continue
            end
            [M,V] = getTriUnitStiff(p1,p2,p3,func);
            % put into stiffM and rightVector
            ks=[row
                code(neighbor(k,1),neighbor(k,2))
                code(neighbor(k+1,1),neighbor(k+1,2))];
            Adj(row, ks(2))=1; Adj(row,ks(3))=1; Adj(ks(2),ks(3))=1;
            for k1=1:3
                rr=ks(k1);
                rightVector(rr) = rightVector(rr) + V(k1);
                for k2=1:3
                    cc=ks(k2);
                    stiffM(rr,cc) = stiffM(rr,cc) + M(k1,k2);
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


