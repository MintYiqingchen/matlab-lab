n=[1];
x=[0];temp=1;
while temp<1000000
    n(length(n)+1)=2*n(length(n));
    temp=n(length(n));
    x(length(x)+1)=x(length(x))+1;
end
str=sprintf('����ϵͳ��%dСʱʱ��ʼ��Ӧ��',x(length(x)));
disp(str);

changen=n;changex=x;

less=2*1e5;temp=n(length(n));
while temp<1e9
    n(length(n)+1)=1.5*n(length(n))-less;
    temp=n(length(n));
    x(length(x)+1)=x(length(x))+1;
end
str=sprintf('��%d��Сʱ�ﵽ10�ڸ�������',x(length(x)));
disp(str);

temp=n(length(n));
while temp<1e12
    n(length(n)+1)=2*n(length(n))-less;
    temp=n(length(n));
    x(length(x)+1)=x(length(x))+1;
end

str=sprintf('��%d��Сʱ�ﵽ1һ���ڸ�������',x(length(x)));
disp(str);

title('δע�俹����')
xlabel('t ʱ��/h')
ylabel('��������/��')

hold on 
plot(x,n)
hold off


    