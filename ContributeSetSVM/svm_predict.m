function pred = svm_predict( w,b,data ,varargin)
%根据data进行二分类

res = w'*data'+b;
pred = res;
pred(pred>0)=1;
pred(pred<0)=-1;
pred=pred';
end

