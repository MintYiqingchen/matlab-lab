S1=table();
S1.Mins = T.Day_Mins+T.Eve_Mins+T.Night_Mins+T.Intl_Mins;
S1.Calls = T.Day_Calls+T.Eve_Calls+T.Night_Calls+T.Intl_Calls;
S1.Charge = T.Day_Charge+T.Eve_Charge+T.Night_Charge+T.Intl_Charge;
S1.CustServ_Calls = T.CustServ_Calls;
figure
set(gcf,'position',[100,50,800,600]);
subplot(2,2,1)
boxplot(S1.Mins,T.Churn)
title('Minutes')
subplot(2,2,2)
boxplot(S1.Calls,T.Churn)
title('Calls')
subplot(2,2,3)
boxplot(S1.Charge,T.Churn)
title('Charge')
subplot(2,2,4)
% === random choice ===
idx = find(G==1);
idx = idx(randperm(sum(G==2)));
hold on
histogram(T.CustServ_Calls(idx));
histogram(T.CustServ_Calls(G==2));
legend({'Not Churn','Churn'});
title('Customer Service Calls')

input('Press to Continue');