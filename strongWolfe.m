function opt_step = strongWolfe( func, grad, x, d )
global logfile;
rho=1e-4; sigma=0.6;

ak=0; ak1=rand(1)*4;
i=1;
while(1)
    % 不满足下降条件
    fprintf(logfile,'strongWolfe:ak1 %8.4f\n',ak1);% display(ak1,'strongWolfe:ak1');
    if(func(x+ak1*d)>func(x)+ak1*rho*grad(x)*d')||(func(x+ak1*d)>=func(x+ak*d))
        fprintf(logfile,'strongWolfe:first condition\n');%display('strongWolfe:first condition');
        opt_step=findin(func, grad, x, d, ak, ak1);
        return;
    end
    % 满足强wolfe准则
    daoshu = grad(ak1*d+x)*d';
    if(abs(daoshu)<= -sigma*grad(x)*d')
        fprintf(logfile,'strongWolfe:second condition\n');% display('strongWolfe:second condition');
        opt_step = ak1;
        return;
    end
    if daoshu>=0
        fprintf(logfile,'strongWolfe:third condition\n');% display('strongWolfe:third condition');
        opt_step=findin(func, grad, x, d, ak,ak1);
        return
    end
    ak=ak1;
    ak1 = ak+rand(1);
    i = i+1;
    fprintf(logfile,'strongWolfe interation: %d\n',i);% display(i, 'strongWolfe interation');
    % 50轮后没有找到的情况
    if i==50
        opt_step=0.0001;break;
    end
end

end

