% 设置日志文件
global logfile;
logfile = fopen('log.txt','w');
%try

    sigma=10; eps1=1e-8; eps=1e-6;
    option = optimset('TolFun',eps1);

    c1 = @(x)((1+x(1)^2)^2+x(2)^2-4);
    f = @(x)(log(1+x(1)^2)-x(2) + 0.5*sigma*c1(x)^2);
    %注意sigma是外部设置的变量

    k=1;
    xk=[2,2];
    while(1)
        objective = @(x)(log(1+x(1)^2)-x(2) + 0.5*sigma*c1(x)^2);
        % 计算梯度函数
        gradf = @(x)([ 2*x(1)/(1+x(1)^2)+sigma*c1(x)*4*(x(1)+x(1)^3), -1+sigma*c1(x)*2*x(2) ]);
        % 差分近似梯度
        gradf_apro = @(x)([objective([x(1)+eps*0.01,x(2)])-objective(x), objective([x(1), x(2)+eps*0.01])-objective(x)]./(eps*0.01));
        %[xk_1, fval] = fminsearch(objective,xk,option);
        [xk_1, fval] = myfminsearch(objective, gradf_apro, xk);
        if(abs(c1(xk_1))<eps)
            answer = [xk_1, fval];
            break;
        end
        sigma = sigma*10;
        xk = xk_1;
        k=k+1;
    end
%end
fprintf('the optimal solution is x=[%.7f,%.7f], f(x)=%.6f\n',xk_1(1),xk_1(2),fval)
fclose(logfile);