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
while temp<1e9
    n(length(n)+1)=1.5*n(length(n))-less;
    temp=n(length(n));
    x(length(x)+1)=x(length(x))+1;
end
str=sprintf('第%d个小时达到10亿个病毒。',x(length(x)));
disp(str);

temp=n(length(n));
while temp<1e12
    n(length(n)+1)=2*n(length(n))-less;
    temp=n(length(n));
    x(length(x)+1)=x(length(x))+1;
end

str=sprintf('第%d个小时达到1一万亿个病毒。',x(length(x)));
disp(str);

title('未注射抗生素')
xlabel('t 时间/h')
ylabel('病毒数量/个')

hold on 
plot(x,n)
hold off


    