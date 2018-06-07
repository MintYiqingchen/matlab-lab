function res = setGini( labels )
[g,~] = findgroups(labels);
if length(g)>1
    ns = splitapply(@length, labels, g);
    ps = ns./length(g);
    res = 1-sum(ps.^2);
else
    res = 0;
end
end


