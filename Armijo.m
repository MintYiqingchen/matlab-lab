function alpha = Armijo( func, pho, x, g, d )
% func 目标函数
%   pho = 10^-3
% x 当前迭代点，g 当前梯度，d搜索方向
alpha = 1.5;
m=0.8;
while(m<=20)
    a1 = func(x+alpha.*d);
    a2 = func(x)+pho*alpha*g'*d;
    if(a1<=a2)
        break;
    else
        alpha = alpha*m;
    end
end
%alpha = alpha;
end

