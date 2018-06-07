function alpha = Wolfe(func, gfunc, pho, sigma, x, g, d)
% pho ����Armijo׼����ͬ�� һ��Ϊ 0.001
% sigma ��֮ǰб�ʵ�ϵ��
% ���в�����ϵ���� 0<pho<0.5<sigma<1
% ʵ�ַ����Ƕ��ֲ���
a = 0.0001; b = 3;
alpha=1.5;
max_iter = 20;
iter = 0;
while(1)
   fk1 = func(x+alpha*d);
   gk1 = gfunc(x+alpha*d);
   if(iter>max_iter)
       break;
   end
   iter = iter+1;
   if (fk1>func(x)+pho*alpha*g'*d )
       b = alpha;
       alpha = (b-a)/2 + a;
   elseif(gk1'*d<sigma*g'*d)
       a = alpha;
       alpha = min(2*a, (b-a)/2 + a);
   else
       break;
   end
end
alpha = alpha;
end