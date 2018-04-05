function [ f, grad, Hess, rfunc, gfunc ] = symWatson( x )
% return rfunc :共i维 r_i(x)
% gfunc: g(x),共length(x)维
% 对应Hessen矩阵，length(x)*length(x)
% input: x 为 n维 符号向量
rfunc=sym(zeros(31,1));
gfunc=sym(zeros(length(x),31));
v = sym(zeros(31,length(x)));
u = sym(zeros(31,length(x)));
for i = 1:31
    si=sym(i);
    for j=1:length(x)
        v(i,j)=subs(subs(sym('(i/29)^j'),'j',sym(j)),'i',si);
        u(i,j)=subs(subs(sym('(j-1)*(i/29)^(j-2)'),'j',sym(j)),'i',si);
    end
    if(i<=29)
        rfunc(i)=-(v(i,:)*x)^2+u(i,:)*x-1;
        gfunc(:,i)=gradient(rfunc(i),x);
    end
end
rfunc(30)=x(1); gfunc(:,30)=gradient(rfunc(30),x);
rfunc(31)=x(2)-x(1)^2-1; gfunc(:,31)=gradient(rfunc(31),x);

f = rfunc'*rfunc;
grad = gradient(f,x);
Hess = hessian(f);
end

