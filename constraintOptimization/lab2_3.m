% 设置日志文件
global logfile;
logfile = fopen('log.txt','w');
%try

    mu=1; eps1=1e-8; eps=1e-6; sigma=10;
    option = optimset('TolFun',eps1);

    objective = @(x)((x(1)-1)^2+(x(1)-x(2))^2+(x(2)-x(3))^4);
    c1 = @(x)(x(1)*(1+x(2)^2)+x(3)^4-4-3*2^0.5);
    c2 = @(x)([x(1),-x(1), x(2), -x(2), x(3), -x(3)]+10);

    k=1;
    xk=[2,2,2];
    % 初始化lambda
    ilbd_k = rand(1,6)*10; elbd_k = 1;
    
    while(k<=40)
       tempc = c2(xk)-ilbd_k./sigma; % c_i(x)-lbd_i/sigma
       ivalue = min(tempc,0); % 存放无约束最优化 min(c_i(x)-lbd_i/sigma, 0)
       % 构造新的拉格朗日方程
       f = @(x)(objective(x)-elbd_k*c1(x)+0.5*sigma*c1(x)^2+0.5*sigma*sum(ivalue.^2-(ilbd_k./sigma).^2));
       % 差分近似梯度
       gradf_apro = @(x)(([f(x+[eps*0.01,0,0]), f(x+[0,eps*0.01,0]), f(x+[0,0,eps*0.01])]-f(x))./(eps*0.01));
       
       [xk1, fval] = fminsearch(f, xk,option);
       %[xk1, fval] = myfminsearch(f, gradf_apro, xk);
       
       % 更新lambda
       elbd_k=elbd_k-sigma*c1(xk1);
       tempc1 = c2(xk1)-ilbd_k./sigma;
       ivalue1 = min(tempc1,0);
       ilbd_k1 = -sigma*ivalue1;

       if(sqrt(c1(xk1)^2 + sum((ivalue1+ilbd_k).^2))<eps)
           break;
       end

       ilbd_k=ilbd_k1;
       sigma = sigma*10;
       xk=xk1;
       k=k+1;
    end
%end
fprintf('the optimal solution is x=[%.7f,%.7f,%.7f], f(x)=%.6f\n',xk1, objective(xk1));
fclose(logfile);
