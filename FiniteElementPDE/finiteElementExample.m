% Poisson Equation Example
% ========== Triangle Linear Unit =========
f = @(x,y)(2.*sin(x).*sin(y));
% f=@(x,y)2;
[TU, ~, Coor, Adj]=triangleFiniteElement(f, [0,pi],[0,pi],9,9);
figure
subplot(1,2,1,'align');
gplot(Adj,Coor);
X = linspace(0,pi,9); Y=linspace(pi,0,9);
[X,Y]=meshgrid(X,Y);
subplot(1,2,2,'align');
meshc(X,Y,TU);
% ========= Rectangle Linear Unit =========
[RU, code, Coor, Adj]=rectangleFiniteElement(f, [0,pi],[0,pi],9,9);
figure
subplot(1,2,1,'align');
gplot(Adj,Coor);
X = linspace(0,pi,9); Y=linspace(pi,0,9);
[X,Y]=meshgrid(X,Y);
subplot(1,2,2,'align');
meshc(X,Y,RU);