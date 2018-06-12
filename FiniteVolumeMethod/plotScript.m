figure
pdegplot(dgm,'EdgeLabels','on','SubdomainLabels','on');
axis equal
[p,e,t] = initmesh(dgm);
pdemesh(p,e,t);
input('press to Continue.');
surfc(X,Y,Z);
figure
scatter3(TR.Points(:,1),TR.Points(:,2), U);
