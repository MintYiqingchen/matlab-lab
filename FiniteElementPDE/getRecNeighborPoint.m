function neighbors = getRecNeighborPoint( a,b )
neighbors = [
    a, b-1;
    a+1, b-1;
    a+1, b;
    a+1, b+1;
    a, b+1;
    a-1, b+1;
    a-1, b;
    a-1, b-1];
end

