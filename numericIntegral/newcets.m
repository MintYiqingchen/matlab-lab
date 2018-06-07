function [res,err]=newcets(f,a,b)
%需要四个样本点，代数精度为5
n=4;
step=(b-a)/4;
xk=linspace(a,b,n);

%求解积分系数
Ak=[0,0,0,0];
fk=[];
for i=1:n
    txk=xk;
    txk(i)=[];
    pn=poly(txk);
    f1=@(x)(polyval(pn,x)/polyval(pn,xk(i)));
    Ak(i)=integral(f1,a,b);
    fk(i)=f(xk(i));
end
%求积分
res=sum(Ak.*fk);
%调用函数检验
int=integral(f,a,b)
err=abs(int-res);
