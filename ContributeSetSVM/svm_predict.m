function pred = svm_predict( w,b,data ,varargin)
%����data���ж�����

res = w'*data'+b;
pred = res;
pred(pred>0)=1;
pred(pred<0)=-1;
pred=pred';
end

