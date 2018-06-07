% calculate mean for each group
[G,Labels] = findgroups(T.Churn);
A = table();
A.MeanDayMin=splitapply(@mean,T.Day_Mins,G);
A.MeanDayCalls=splitapply(@mean, T.Day_Calls, G);
A.MeanDayCharge=splitapply(@mean, T.Day_Charge, G);
A.MeanEveMin=splitapply(@mean, T.Eve_Mins, G);
A.MeanEveCalls=splitapply(@mean, T.Eve_Calls, G);
A.MeanEveCharge=splitapply(@mean, T.Eve_Charge, G);
A.MeanNigMin=splitapply(@mean, T.Night_Mins, G);
A.MeanNigCalls=splitapply(@mean, T.Night_Calls, G);
A.MeanNigCharge=splitapply(@mean, T.Night_Charge, G);
A.MeanIntMin=splitapply(@mean, T.Intl_Mins, G);
A.MeanIntCall=splitapply(@mean, T.Intl_Calls, G);
A.MeanIntCharge=splitapply(@mean, T.Intl_Charge, G);
A.Properties.RowNames={'Not Churn','Churn'};

% === figure =====
figure;
b=bar(table2array(A),'grouped');
set(gca,'xticklabel',A.Properties.RowNames);
legend(A.Properties.VariableNames);
grid on
input('Press to Continue');