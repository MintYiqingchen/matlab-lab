function score = accuracy_score( gt, pred )
%根据ground truth和pred结果计算精确度
assert(length(gt)==length(pred),'向量维数不相同!');
good = 0;
for i=1:length(gt)
    if gt(i)==pred(i)
        good = good+1;
    end
end
score = good/length(gt);

