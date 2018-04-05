function [int,err]=Gauss(func,a,b,n)
%func待积分函数
%[a,b]积分上下限

%求解k=4勒让德公式的系数
k=4;
syms x
p=sym2poly(diff((x^2-1)^(k),k)/(2^k*factorial(k)));
%求解高斯点
tk=roots(p);

%计算求积系数
Ak=[0 0 0 0];
for i=1:k
    temp=tk;
    temp(i)=[];
    pn=poly(temp);
    f1=@(x)polyval(pn,x)/polyval(pn,tk(i));
    Ak(i)=integral(f1,-1,1);
end
%为每个小区间求高斯积分
sample=linspace(a,b,n);
step=(b-a)/n;
int=0;
for i=2:length(sample)
    %将高斯点变换到每一个子区间
   point=(sample(i)-sample(i-1))*(tk+1)/2+sample(i-1);
   fx=func(point);
   int=int+sum(Ak'.*fx);
end
int=int*step/2;
%调用积分函数检验
cek=integral(func,a,b);
err=abs(cek-int);
   
    
