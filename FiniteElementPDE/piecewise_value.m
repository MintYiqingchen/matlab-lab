function yy=piecewise_value(xxs, breaks,polys)
% xxs:[Num] sorted numbers
% breaks: L+1 [Num]
% polys: result returned by solvePartialEquation
assert(all(breaks(1)<=xxs<=breaks(end)),'points in xxs should all be in valid interval');
assert(length(breaks)-1==size(polys,1),'Number of polynomials in polys should be equal to length(breaks)-1');
affine = @(x,a,b)((x-a)./(b-a));

yy = zeros(1,length(xxs));
curr_interval = breaks(1:2);
pp = polys(1,:);
curr=1; 
for i=1:length(xxs)
    while xxs(i)>curr_interval(2)
        curr = curr+1;
        curr_interval=breaks(curr:curr+1);
        pp=polys(curr,:);
    end
    yy(i)=polyval(pp,affine(xxs(i), curr_interval(1),curr_interval(2)));
end