function alpha = Armijo( func, pho, x, g, d )
% func Ŀ�꺯��
%   pho = 10^-3
% x ��ǰ�����㣬g ��ǰ�ݶȣ�d��������
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

