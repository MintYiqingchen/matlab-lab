function val = calculateTriValue( x,y,x_border, y_border, matrixU )
% code, innerU must be output of triangleFiniteElment
% x,y: point coordinate
% x_border, y_boreder:must as same as triangleFiniteElment
delta_x = (x_border(2)-x_border(1))/(size(matrixU,2)-1);
delta_y = (y_border(2)-y_border(1))/(size(matrixU,1)-1);
% grid coordinate
gc = floor((x-x_border(1))/delta_x)+1;
gr = floor((y_border(2)-y)/delta_y)+1;
if gc==size(matrixU,2) || gr==size(matrixU,1)
    val=matrixU(gr,gc);
    return
end
% left lower triangle or right upper triangle
rem_y=y-delta_y*(gr-1);
rem_x=x-delta_x*(gc-1);
k1 = -delta_y./delta_x;
k2 = -(delta_y-rem_y)./(delta_x-rem_x);
if k2 >= k1 % left low
    p1=[x_border(1)+delta_x*(gc-1), y_border(2)-delta_y*(gr-1), matrixU(gr,gc)];
    p2=[x_border(1)+delta_x*gc, y_border(2)-delta_y*gr, matrixU(gr,gc+1)];
    p3=[p1(1), p2(2), matrixU(gr+1,gc)];
else
    p1=[x_border(1)+delta_x*(gc-1), y_border(2)-delta_y*gr, matrixU(gr+1,gc)];
    p2=[x_border(1)+delta_x*gc, y_border(2)-delta_y*(gr-1), matrixU(gr, gc+1)];
    p3=[p2(1), p1(2), matrixU(gr+1, gc+1)];
end
% get correspond base L
S_mu = 0.5*delta_x*delta_y;
P = [p1;p2;p3];
val = 0.0;
for i=1:3
    p2 = P(mod(i,3)+1,:);
    p3 = P(mod(i+1,3)+1,:);
    a = p2(1)*p3(2)-p3(1)*p2(2);
    b = p2(2)-p3(2);
    c = p3(1)-p2(1);
    u = P(i,3);
    val = val+(0.5.*u.*(a+b.*x+c.*y)./S_mu);
end
end

