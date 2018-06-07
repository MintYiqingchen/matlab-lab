% min and calls
S2 = S1;
S2.CustServ_Calls = T.CustServ_Calls;
S2 = sortrows(S2,'Mins');
figure;
set(gcf,'position',[150,50,640,640]);
ax=subplot(2,2,1);
scatter(S2.Mins, S2.Calls);
xlabel(ax,'Minutes')
ylabel(ax,'Calls')

ax=subplot(2,2,2);
scatter(S2.Mins,S2.Charge);
xlabel(ax,'Minutes');
ylabel(ax,'Charge');

ax=subplot(2,2,3);
scatter(S2.Mins,S2.CustServ_Calls);
xlabel(ax,'Minutes');
ylabel(ax,'Customer service');

S2 = table();
S2.Intl_Mins = T.Intl_Mins;
S2.Intl_Plan = T.Intl_Plan;
S2 = sortrows(S2, 'Intl_Mins');
ax=subplot(2,2,4);
scatter(S2.Intl_Mins,S2.Intl_Plan);
xlabel(ax,'International Minute');
ylabel(ax,'International Plan');

input('Press to Continue');