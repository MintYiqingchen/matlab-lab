function [ x_star,fval ] = bfgs( func, grad,x,eps, iteration)
global logfile;

Hk=eye(length(x));
xk=x;
for i=1:iteration
    if norm(grad(xk))<eps
        x_star=xk; fval=func(xk);
        return;
    end
    dk = (-Hk*grad(xk)')';dk=dk./norm(dk);
    fprintf(logfile,'bfgs iteration %d: |gk|:%.6f fk:%.6f\n',i, norm(grad(xk)), func(xk)); %display(grad(xk), 'bfgs gk');
    
    step = strongWolfe(func, grad, xk,dk);
    xk1 = xk+step*dk;
    
    yk=grad(xk1)-grad(xk)+eps*1e-5; sk=xk1-xk+eps*1e-5;
    Hk = Hk + (1+yk*Hk*yk'/(yk*sk'))*(sk'*sk)/(yk*sk')-(sk'*yk*Hk+Hk*yk'*sk)/(yk*sk');
    
    xk=xk1;
end

x_star=xk; fval=func(xk);
end

