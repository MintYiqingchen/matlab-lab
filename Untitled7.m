mu=1; eps1=1e-8; eps=1e-6;
option = optimset('TolFun',eps1);

objective = @(x)((x(1)-1)^2+(x(1)-x(2))^2+(x(2)-x(3))^4);

k=1;
xk=[2,2,2];
while(1)
    c = [xk(1),-xk(1),xk(2),-xk(2),xk(3),-xk(3)]+10;
    f = @(x)(objective(x)-mu*sum(log(c)));
    [xk1, fval] = fminsearch(f, xk, option);
    c1 = [xk1(1),-xk1(1),xk1(2),-xk1(2),xk1(3),-xk1(3)]+10;
    if(abs(mu*sum(log(c1)))<eps)
        break;
    end
    
    mu=0.5*mu;
    xk=xk1;
    k=k+1;
end
display([xk1, fval]);