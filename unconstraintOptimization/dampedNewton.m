function d = dampedNewton(Hess, x, g)
% output:d ţ�ٷ���
% input: g Ϊ�������ݶ�
H = Hess(x);
d = -H\g;
end