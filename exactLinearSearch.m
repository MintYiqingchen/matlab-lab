function alpha = exactLinearSearch( func, epsilon, phi,t, x, d)
%0.618 法近似精确线搜索步长
% func：目标函数
% epsilon 区间threshold, phi:函数下降比例系数，t 搜索初始区间的系数
% x 当前迭代点, d 搜索方向

% 求解初始区间 [a, b]
alpha_i = 0.5;
i=0;
while(1)
    alpha_i1 = alpha_i+phi;
    if(alpha_i1>0 && func(x+alpha_i.*d)>func(x+alpha_i1.*d))
        phi = phi*t;
        alpha=alpha_i;
        alpha_i=alpha_i1;
        i=i+1;
    elseif(i==0)
        phi=-phi;
        alpha=alpha_i1;
        i=i+1;
    else
        a = min(alpha, alpha_i1);
        b = max(alpha, alpha_i1);
        break;
    end
end
% 求解近似极小点
t=(sqrt(5)-1)/2;
while(b-a>epsilon)
    lalpha=a+(1-t)*(b-a);
    ralpha=a+t*(b-a);
    if(func(x+lalpha.*d)<func(x+ralpha.*d))
        b=ralpha;
    else
        a=lalpha;
    end
end

alpha=(a+b)/2;

end

