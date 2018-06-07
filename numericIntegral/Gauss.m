function [int,err]=Gauss(func,a,b,n)
%func�����ֺ���
%[a,b]����������

%���k=4���õ¹�ʽ��ϵ��
k=4;
syms x
p=sym2poly(diff((x^2-1)^(k),k)/(2^k*factorial(k)));
%����˹��
tk=roots(p);

%�������ϵ��
Ak=[0 0 0 0];
for i=1:k
    temp=tk;
    temp(i)=[];
    pn=poly(temp);
    f1=@(x)polyval(pn,x)/polyval(pn,tk(i));
    Ak(i)=integral(f1,-1,1);
end
%Ϊÿ��С�������˹����
sample=linspace(a,b,n);
step=(b-a)/n;
int=0;
for i=2:length(sample)
    %����˹��任��ÿһ��������
   point=(sample(i)-sample(i-1))*(tk+1)/2+sample(i-1);
   fx=func(point);
   int=int+sum(Ak'.*fx);
end
int=int*step/2;
%���û��ֺ�������
cek=integral(func,a,b);
err=abs(cek-int);
   
    
