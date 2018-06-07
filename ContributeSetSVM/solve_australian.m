% australian 求解脚本
% 载入变量
load('australian.mat');

[w, b, alpha] = train_svm(australian_Tr, australian_Tr_Lb,australian_para_C);
display(w');display(b');display(alpha');
pred = svm_predict(w, b, australian_Ts);
accu = accuracy_score(australian_Ts_Lb, pred);
fprintf('accuracy acore for test: %f\n',accu);

pred = svm_predict(w, b, australian_Tr);
accu = accuracy_score(australian_Tr_Lb, pred);
fprintf('accuracy acore for train: %f\n',accu);