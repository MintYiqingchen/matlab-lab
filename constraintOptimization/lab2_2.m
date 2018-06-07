% 设置日志文件
global logfile;
logfile = fopen('log.txt','w');

%try
    sigma=10; eps1=1e-8; eps=1e-6;
    option = optimset('TolFun',eps1);

    f = @(x)(-x(1)*x(2)*x(3));
    c1 = @(x)(-x(1)^2-2*x(2)^2-4*x(3)^2+48);

    k=1; lbd = 1;
    xk = [-1,1,-1];
    while(1)
        % min(c(x)-lbd./sigma,0)
        objective = @(x)(f(x)+0.5*sigma*(min(c1(x)-lbd./sigma,0)^2-(lbd./sigma)^2));
        % 差分近似梯度:基本上不能用了
        gradf_apro = @(x)(([objective(x+[eps*0.01,0,0]), objective(x+[0,eps*0.01,0]), objective(x+[0,0,eps*0.01])]-objective(x))./(eps*0.01));
        %[xk1, fval] = fminsearch(objective, xk, option);
        [xk1, fval] = myfminsearch(objective, gradf_apro, xk);
        
        lbd = -sigma*min(c1(xk1)-lbd./sigma,0);
        if norm(c1(xk))<eps
            break;
        end
        xk = xk1;
        sigma = sigma*10;
        k=k+1;
    end
%end
fprintf('the optimal solution is x=[%.7f,%.7f, %.7f], f(x)=%.6f\n',xk1,-xk1(1)*xk1(2)*xk1(3));
fclose(logfile);