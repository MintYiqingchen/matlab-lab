function score = accuracy_score( gt, pred )
%����ground truth��pred������㾫ȷ��
assert(length(gt)==length(pred),'����ά������ͬ!');
good = 0;
for i=1:length(gt)
    if gt(i)==pred(i)
        good = good+1;
    end
end
score = good/length(gt);

