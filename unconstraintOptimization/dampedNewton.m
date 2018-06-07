function d = dampedNewton(Hess, x, g)
% output:d 牛顿方向
% input: g 为迭代点梯度
H = Hess(x);
d = -H\g;
end