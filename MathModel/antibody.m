n=[1];
x=[0];temp=1;
while temp<1000000
    n(length(n)+1)=2*n(length(n));
    temp=n(length(n));
    x(length(x)+1)=x(length(x))+1;
end
str=sprintf('免疫系统在%d小时时开始响应。',x(length(x)));
disp(str);

changen=n;changex=x;

less=2*1e5;temp=n(length(n));
while x(length(x))<38
    n(length(n)+1)=1.5*n(length(n))-less;
    temp=n(length(n));
    x(length(x)+1)=x(length(x))+1;
end

less=5e8;temp=n(length(n));
while 1
    if n(length(n))*1.5-less<0
        n(length(n)+1)=0;
        x(length(x)+1)=x(length(x))+1;
        break
    else
       n(length(n)+1)=1.5*n(length(n))-less;
       x(length(x)+1)=x(length(x))+1;
    end
end

title('38小时注射抗生素')
xlabel('t 时间/h')
ylabel('病毒数量/个')

hold on 
plot(x,n)
hold off