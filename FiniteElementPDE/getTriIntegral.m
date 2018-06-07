function res = getTriIntegral(func, pa, pb, pc)
if all(pa-pb)
    p2=pa; p3=pb;p1=pc;
elseif all(pa-pc)
    p2=pa; p3=pc; p1=pb;
else
    p2=pb; p3=pc;p1=pa;
end

A=[p2(1),1;p3(1),1];
b=[p2(2);p3(2)];
line=A\b;
limit_func=@(x)(line(1).*x+line(2));

minval=min(cat(1,p1,p2,p3),[],1);
maxval=max(cat(1,p1,p2,p3),[],1);
if p1(2)-limit_func(p1(1))<0 % 下三角
    res=integral2(func, minval(1), maxval(1),minval(2),limit_func);
else % 上三角
    res=integral2(func, minval(1), maxval(1),limit_func, maxval(2));
end
end

