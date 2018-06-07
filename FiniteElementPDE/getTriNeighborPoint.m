function neighbor = getTriNeighborPoint(a,b)
%get anticlockwise neighbor points
%   (a,b): grid coordinate
neighbor=[ % anticlockwise
        a, b-1;
        a+1, b;
        a+1, b+1;
        a, b+1;
        a-1, b;
        a-1, b-1];
end

