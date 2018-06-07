function [TPR, FPR, Gini] = ROC( preds, label )
[preds, idx]=sort(preds,'descend');
label = label(idx);
TPR = zeros(length(preds),1);
FPR = zeros(length(preds),1);
Gini = zeros(length(preds),1);
P = sum(label==1);
N = length(label)-P;
for i =1:P+N
    [TP,~,FP,~] = evaluation_result(preds, label, preds(i));
    TPR(i)=TP/P;
    FPR(i)=FP/N;
    Gini(i)=i.*setGini(label(1:i));
    Gini(i)=Gini(i)+(P+N-i).*setGini(label(i+1:end));
end
Gini = Gini./(N+P);
end

