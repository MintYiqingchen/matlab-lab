% group analysis of nominal value
g1 = findgroups(T.Churn, T.Area_Code2);
sums = splitapply(@length, T.Area_Code2, g1);
figure
set(gcf, 'position',[0,0,1000,600]);
ax1=subplot(2,4,1);
pie(ax1,sums(1:3),{'0','1','2'});
title(ax1, 'Area Code Not Churn');
ax1=subplot(2,4,5);
pie(ax1,sums(4:6),{'0','1','2'});
title(ax1, 'Area Code Churn');

g1 = findgroups(T.Churn, T.Intl_Plan);
sums = splitapply(@length, T.Intl_Plan, g1);
ax1=subplot(2,4,2);
pie(ax1,sums(1:2),{'0','1'});
title(ax1, 'Plan Not Churn');
ax1=subplot(2,4,6);
pie(ax1,sums(3:4),{'0','1'});
title(ax1, ' Plan Churn');

% === Vmail ===
g1 = findgroups(T.Churn, T.Vmail);
sums = splitapply(@length, T.Vmail, g1);
ax1=subplot(2,4,3);
pie(ax1,sums(1:2),{'0','1'});
title(ax1, 'Vmail Not Churn');
ax1=subplot(2,4,7);
pie(ax1,sums(3:4),{'0','1'});
title(ax1, ' Vmail Churn');

% === Vmail Message ===
VM = T.Vmail_Message;
VM(VM<10&VM>0)=1; VM(VM<20 & VM>=10)=2; VM(VM<30&VM>=20)=3;
VM(VM<40 & VM>=30)=4; VM(VM<50 & VM>=40)=5; VM(VM<60&VM>=50)=6;
names = {'0','1-9','10-19','20-29','30-39','40-49','50-59'};
%VM(VM==0)=0;
%VM(VM>0)=1;
[g1,id1,id2] = findgroups(T.Churn, VM);
sums = splitapply(@length, VM, g1);
ax1=subplot(2,4,4);
pie(ax1,sums(1:7));
% legend(names);
% pie(ax1,sums(1:2),{'==0','>0'});
title(ax1, 'VM Not Churn');
ax1=subplot(2,4,8);
id2 = id2+1;
pie(ax1,sums(8:end));
%pie(ax1,sums(3:end),{'==0','>0'});
title(ax1, ' VM Churn');

input('Press to Continue');