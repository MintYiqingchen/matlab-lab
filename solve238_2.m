% 第二题求解脚本
G = [4 2 2;
    2 4 0;
    2 0 2];
h = [-8; -6; -4];
Agt = vertcat([-1 -1 -2],eye(3));
bgt = [-3;0;0;0];
x0=[0.5;0.5;0.5];
f = @(x)(0.5*x'*G*x+h'*x);
tic();
[x_star,l_star] = contribute_set(G,h,Agt,bgt,x0,eps,'verbose');
toc();
display(x_star,'minimal point');
display(l_star,'lagrange multiplier');
display(f(x_star),'Minimal value');
