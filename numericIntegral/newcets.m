function [res,err]=newcets(f,a,b)
%��Ҫ�ĸ������㣬��������Ϊ5
n=4;
step=(b-a)/4;
xk=linspace(a,b,n);

%������ϵ��
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
%�����
res=sum(Ak.*fk);
%���ú�������
int=integral(f,a,b)
err=abs(int-res);
