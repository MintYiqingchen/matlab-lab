p = @(x)(1);
q = @(x)(0.5*pi.^2);
f = @(x)(0.5*pi.^2*sin(x*pi./2));
k=2;
% set different partition granular
for granular=3:5
breaks = linspace(0,1,granular);
[respoly,coefM, ppM] = solvePartialEquation(p,q,f,breaks,k,false);
display(respoly,'[0,1] polynomial');
display(coefM,'u(x)');
display(ppM,'[0,1] trivial polynomial')
% ppM is in [0,1]
% when compute, affine transformation should be applied
for i=1:length(breaks)-1
    xx=linspace(breaks(i),breaks(i+1),50);
    yy = piecewise_value(xx, breaks,respoly);
    %xx=linspace(0,1,50);
    %yy=polyval(respoly(i,:),xx);
    hold on;
    plot(xx,yy);
end
end

