% test case
func_f=@(x,y)(2.*sin(x).*sin(y));
rect = [3;4; 0;0;pi;pi; 0;pi;pi;0];
shape_names = char('rect')';
sf = 'rect';
[dgm,bt]=decsg(rect,sf,shape_names);
dgm = csgdel(dgm,bt);
tic();
[U, TR] = FMV(func_f, dgm, {'essential',0});
toc();
X = linspace(0,pi,100);
Y = X;
[X,Y]=meshgrid(X,Y);
Z = zeros(size(X,1),size(X,2));
for i=1:size(X,2)
    Z(:,i)=calculatePointValue(TR, U,[X(:,i) Y(:,i)]);
end
plotScript

% natural
[U, TR] = FMV(func_f, dgm, {'natural',1,1});
X = linspace(0,pi,100);
Y = X;
[X,Y]=meshgrid(X,Y);
Z = zeros(size(X,1),size(X,2));
for i=1:size(X,2)
    Z(:,i)=calculatePointValue(TR, U,[X(:,i) Y(:,i)]);
end
plotScript

