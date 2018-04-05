% 第一题求解脚本
G = [2 0 0 0 0;
    0 2 -2 0 0;
    0 -2 2 0 0;
    0 0 0 2 -2; 
    0 0 0 -2 2];
h = [-2;0;0;0;0];
A = [1 1 1 1 1;
    0 0 1 -2 -2];
b = [5;-3];
f = @(x)(0.5*x'*G*x+h'*x);
tic();
[x_star, lambda] = minimize_sqr_eqal_cons(G,h,A,b);
toc();
display(x_star, 'Minimal point');
display(f(x_star),'Minimal value');
display(lambda, 'Lagrange mutiplier');