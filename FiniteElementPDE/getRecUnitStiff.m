function [ M,V ] = getRecUnitStiff(func, p1,p2, p3, p4)
V = zeros(4,1);
M = zeros(4);
P = cat(1,p1,p2,p3,p4);
minval=min(P,[],1);
maxval=max(P,[],1);
xh = maxval(1)-minval(1);
yh = maxval(2)-minval(2);
for i=1:4
    base_i=@(x,y)(1-abs(x-P(i,1))./xh).*(1-abs( y-P(i,2) )./yh);
    % numeric partial
    partial_ix=@(x,y)(base_i(x+1e-10,y)-base_i(x,y))./1e-10;
    partial_iy=@(x,y)(base_i(x,y+1e-10)-base_i(x,y))./1e-10;
    V(i)=integral2(@(x,y)base_i(x,y).*func(x,y),minval(1),maxval(1), minval(2), maxval(2));
    for j=i:4
        base_j=@(x,y)(1-abs(x-P(j,1))./xh).*(1-abs( y-P(j,2) )./yh);
        partial_jx=@(x,y)(base_j(x+1e-10,y)-base_j(x,y))./1e-10;
        partial_jy=@(x,y)(base_j(x,y+1e-10)-base_j(x,y))./1e-10;
        % partial integral
        M(i,j)=integral2(@(x,y)partial_ix(x,y).*partial_jx(x,y)+partial_iy(x,y).*partial_jy(x,y),...
            minval(1),maxval(1), minval(2), maxval(2));
        M(j,i)=M(i,j);
    end
end
end

