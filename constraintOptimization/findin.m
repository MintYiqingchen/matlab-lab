function opt_step = findin( func, grad, x, d, lo, hi )
%func, grad���Ǻ���, x����ǰ���ֵ��d���½�����
%   lo�������½� hi�������Ͻ�;���������еĲ���ֵ
global logfile;

EPSILON=1e-10; sigma=0.6; rho=1e-4;
opt_step=(lo+hi)/2; % �Ҳ������ʲ���ʱ�ķ���ֵ
% 3��hermite��ֵ
iteration = 1;
while(1)
    % �����ֵ����ʽ
    pp = hermite_interpolate(lo, hi, func(lo*d+x), func(hi*d+x), grad(lo*d+x)*d', grad(hi*d+x)*d');
    k = polyder(pp);
    rt = roots(k)';
    % ѡ����ʵĸ�,���е�Ϊ��ʼֵ
    aj=(lo+hi)/2;mmin=func(x+aj*d);
    for i = rt
        if isreal(i) && i<=hi && i>=lo && func(x+i*d)<mmin
            aj=i;mmin=func(x+i*d);
        end
    end
    
    if func(x+aj*d)>func(x)+rho*grad(x)*d' || func(x+aj*d)>=func(x+lo*d)
        hi=aj;
    else
        daoshu=grad(x+aj*d)*d';
        if abs(daoshu)<= -sigma*grad(x)*d'
            opt_step=aj;
            fprintf(logfile, 'findin function normal exit, step=%e\n',opt_step);
            return;
        end
        if daoshu*(hi-lo)>=0 % ͬ�������,��Ҫ����������
            hi=lo;
        end
        lo=aj;
    end
    fprintf(logfile,'findin function iteration %d: aj:%e [lo,hi]:%e, %e\n',iteration, aj, lo, hi);
    if(aj<EPSILON || iteration>=50)
        opt_step=aj;
        fprintf(logfile, 'findin function not find opt_step, now step %e\n',opt_step);
        return;
    end
    iteration = iteration+1;
end

