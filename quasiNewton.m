% 拟牛顿方法脚本
xlen = input('size of x\n');
symx = sym('x',[xlen,1]);
xxs = zeros(200,xlen);
x_k = zeros(xlen,1);
xxs(1,:)=x_k';

% 目标函数
tic;
%[ snorm2f, sgfunc, sHess,rfunc ] = symWatson (symx);
toc;
f = @(x)(eval(subs(snorm2f,symx,x)));
gfunc = @(x)(eval(subs(sgfunc,symx,x)));
Hess = @(x)(eval(subs(sHess,symx,x)));

% 超参数
epsilon = 10e-8;

% 终止准则
terminate_f = @(x,y)(abs(x-y)<epsilon);

% 搜索准则
% principle = @(x,d)(exactLinearSearch(f, 0.00001, 0.8,0.5,x,d));
% principle = @(x,g,d)(Armijo( f, 10e-4, x, g, d ));
principle = @(x,g,d)(Wolfe(f,gfunc, 0.001, 0.75, x, g, d)); 

% 矩阵修正公式
sr1 = @(Z, y)((Z*Z')/(Z'*y));
dfp = @(H,s,y)(H+(s*s')/(s'*y)-(H*y*y'*H)/(y'*H*y));
bfgs = @(H,s,y)(H+(1+(y'*H*y)/(y'*s)).*(s*s')./(y'*s)-((s*y'*H+H*y*s')./(y'*s)));
% 初始值
rss = zeros(200,1);
display('开始迭代');
r_k = f(x_k);rss(1)=r_k;
g_k = gfunc(x_k);
d_k = -g_k;
H_k = eye(length(x_k));
iteration = 1;
while(1)
    tic;
    step = principle(x_k,g_k,d_k);
    x_k1 = x_k+step.*d_k; xxs(iteration+1,:)=x_k1';
    r_k1 = f(x_k1); rss(iteration+1)=r_k1;
    g_k1 = gfunc(x_k1);
    if(terminate_f(r_k1,r_k))
        break
    end
    if(isnan(r_k1))
        break;
    end
    s_k = x_k1-x_k;
    y_k = g_k1-g_k;
    
   % Z = s_k-H_k*y_k; H_k1 = sr1(Z, y_k)+H_k;
    if(s_k'*y_k>0)
        H_k1 = dfp(H_k,s_k,y_k);
        %H_k1 = bfgs(H_k,s_k,y_k);
    else
        H_k1 = H_k;
    end
    
    d_k = -H_k1*g_k;
    
    x_k = x_k1;g_k=gfunc(x_k);r_k=r_k1;
    iteration = iteration+1
    if (iteration>=1500)
        break;
    end
    toc;
end
%验证函数
display('开始验证程序...');
tic;
[truex,truef] = lsqnonlin(@(x)(eval(subs(rfunc,symx,x))),zeros(xlen,1));
toc;