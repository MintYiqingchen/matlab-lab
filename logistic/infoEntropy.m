function entropy = infoEntropy( labels )
% labels should be a table type
[g,~] = findgroups(labels);
ns = splitapply(@length, labels, g);
ps = ns./length(g);
entropy = -sum(ps.*log2(ps));
end

