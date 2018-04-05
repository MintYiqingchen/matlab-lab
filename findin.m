function opt_step = findin( func, grad, x, d, lo, hi )
%func, grad都是函数, x：当前点的值，d：下降方向
%   lo：区间下界 hi：区间上界;返回区间中的步长值
global logfile;

EPSILON=1e-10; sigma=0.6; rho=1e-4;
opt_step=(lo+hi)/2; % 找不到合适步长时的返回值
% 3次hermite插值
iteration = 1;
while(1)
    % 构造插值多项式
    pp = hermite_interpolate(lo, hi, func(lo*d+x), func(hi*d+x), grad(lo*d+x)*d', grad(hi*d+x)*d');
    k = polyder(pp);
    rt = roots(k)';
    % 选择合适的根,以中点为起始值
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
        if daoshu*(hi-lo)>=0 % 同号情况下,需要往反方向找
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

