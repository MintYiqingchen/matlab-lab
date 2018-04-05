function alpha = exactLinearSearch( func, epsilon, phi,t, x, d)
%0.618 �����ƾ�ȷ����������
% func��Ŀ�꺯��
% epsilon ����threshold, phi:�����½�����ϵ����t ������ʼ�����ϵ��
% x ��ǰ������, d ��������

% ����ʼ���� [a, b]
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
% �����Ƽ�С��
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

