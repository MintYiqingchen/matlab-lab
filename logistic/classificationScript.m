sigmoid = @(data)1./(1+exp(-data));

idx = randperm(5000);
train_data = table2array(T(idx(1:3500),1:17));
train_norm = normalize(train_data);
train_label = T.Churn(idx(1:3500));
[w,b]=logistic_train(train_norm, train_label,...
    0.007, 100, 10, 10, 1000);

% evaluate on val
val_data = table2array(T(idx(3501:5000),1:17));
val_norm = normalize(val_data);
val_label = T.Churn(idx(3501:5000));
preds = sigmoid(val_norm*w+b);
[TP,TN,FP,FN] = evaluation_result(preds, val_label,0.5);
format compact
confusion_val = array2table([TP FN; FP TN],...
    'VariableNames',{'pred_yes','pred_no'},...
    'RowNames',{'real_yes','real_no'})
format
% ROC line
[TPR, FPR, Gini_val]=ROC(preds, val_label);
figure;
set(gcf,'position',[100,50,800,500]);
% ROC
subplot(1,2,1);
plot(FPR, TPR,'LineWidth',1.5);
hold on
train_preds = sigmoid(train_norm*w+b);
[TPR,FPR, Gini_train]=ROC(train_preds,train_label);
plot(FPR,TPR,'LineWidth',1.5);
plot(0:1,0:1,'LineWidth',1.5);
legend({'test','train','random'},'Location','southeast')
title('ROC')
xlabel('FPR'); ylabel('TPR');
hold off
% Gini
subplot(1,2,2);
plot(linspace(0,1,length(Gini_val)), Gini_val,'LineWidth',1.5);
hold on
plot(linspace(0,1,length(Gini_train)), Gini_train, 'LineWidth', 1.5);
legend({'test','train'});
title('Gini Split')
ylabel('Gini');
hold off