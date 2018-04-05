% 迭代求解脚本
xlen = input('size of x\n');
symx = sym('x',[xlen,1]);
xxs = zeros(200,xlen);
x_k = zeros(xlen,1);
xxs(1,:)=x_k';
% 目标函数
tic;
[ snorm2f, sgfunc, sHess,rfunc ] = symWatson (symx);
toc;
f = @(x)(eval(subs(snorm2f,symx,x)));
gfunc = @(x)(eval(subs(sgfunc,symx,x)));
Hess = @(x)(eval(subs(sHess,symx,x)));
% f = @(x)(1/2.*x'*[21 4;4 15]*x+[2,3]*x);
% gfunc = @(x)([21 4;4 15]*x+[2 3]');
% Hess = @(x)([21 4;4 15]);
% 超参数
epsilon = 10e-6;
% 终止准则
terminate_f = @(x,y)(abs(x-y)<epsilon);
terminate_grad = @(g1,g2)(sqrt((g1-g2)'*(g1-g2))<epsilon);
% 搜索准则
% principle = @(x,d)(exactLinearSearch(f, 0.00001, 0.8,0.5,x,d));
% principle = @(x,g,d)(Armijo( f, 10e-4, x, g, d ));
principle = @(x,g,d)(Wolfe(f,gfunc, 0.001, 0.75, x, g, d)); 
% 初始值
% r_k = testfunc(x_k);g_k=testgrad(x_k);
rss = zeros(200,1);
display('开始迭代');
tic;
r_k = f(x_k);rss(1)=r_k;
g_k = gfunc(x_k);

iteration = int32(1);
while(1)
    %d_k = lmNewton(Hess, x_k, g_k);
    step = principle(x_k,g_k,-g_k);
    
    x_k1=x_k+step.*-g_k;
    xxs(iteration+1,:)=x_k1';
    r_k1=f(x_k1);
    g_k1=gfunc(x_k1);
    rss(iteration+1) = r_k1;
    if(terminate_f(r_k,r_k1))
        break;
    end
    if(isnan(r_k1))
        break;
    end
    iteration = iteration+1
    g_k=g_k1;x_k=x_k1;r_k=r_k1;
end
toc;
%画图
% if(xlen==2)
%     hold on
%     lower = min(min(xxs));upper = max(max(xxs)); 
%     plot(xxs(1:iteration,1),xxs(1:iteration,2),'--gs',...
%     'LineWidth',2,...
%     'MarkerFaceColor',[0.5,0.5,0.5]);
%     ezcontour(@(x,y)(f([x;y])),[lower-0.2,upper+0.2]);
%     hold off
% end 
%验证函数
display('开始验证程序...');
tic;
[truex,truef] = lsqnonlin(@(x)(eval(subs(rfunc,symx,x))),zeros(xlen,1));
toc;