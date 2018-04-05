%调用积分主程序
f=@(x)(sin(x)./x);
%复合高斯求积公式
%{
res=[];
[res(1),laster]=Gauss(f,0,1,2);
for n=2:8
    [res(n),err]=Gauss(f,0,1,2^n);
    %分析误差阶
    sprintf('有%d个区间时:\n误差阶为 %.4f\n积分为%.7f',n,log2(laster/err),res(n))
    laster=err;
end
%}
%n=4的科特斯公式
[resNew,err]=newcets(f,0,1);
disp(resNew);
disp(err);
