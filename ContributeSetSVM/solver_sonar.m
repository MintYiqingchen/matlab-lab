load('sonar.mat');

[w, b,alpha] = train_svm(sonar_Tr, sonar_Tr_Lb, sonar_para_C);
display(w');display(b');display(alpha');
pred = svm_predict(w, b, sonar_Ts);
accu = accuracy_score(sonar_Ts_Lb, pred);
fprintf('accuracy acore for test: %f\n',accu);

pred = svm_predict(w, b, sonar_Tr);
accu = accuracy_score(sonar_Tr_Lb, pred);
fprintf('accuracy acore for train: %f\n',accu);