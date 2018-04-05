% ===============
function res_pp=scalePoly(pp, a,b)
sumpp = sum(pp, 1);
res_pp = mkpp([a,b],sumpp);
end