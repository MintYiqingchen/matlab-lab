function triIdsSort = clockwiseTIdxs(p0, triIds, cCenters)
% p0:(x,y)
% triIdxs, cCenters have the same order
% return: triIdxSort is sorted in clockwise
% review: check pass
tmpX = cCenters(:,1)-p0(1);
tmpY = cCenters(:,2)-p0(2);
vectors = [tmpX tmpY];
triIdsSort = zeros(size(triIds));

num = 0;
% 4ed
condFunc = @(V)(V(:,1)>0&V(:,2)<=0);
tmpTidxs = sortByCos(vectors,condFunc,'descend');
triIdsSort(num+1: num+length(tmpTidxs))=triIds(tmpTidxs);
num = num + length(tmpTidxs);
% 3rd
condFunc = @(V)(V(:,1)<=0&V(:,2)<0);
tmpTidxs = sortByCos(vectors,condFunc,'descend');
triIdsSort(num+1: num+length(tmpTidxs))=triIds(tmpTidxs);
num = num + length(tmpTidxs);
% 2nd
condFunc = @(V)(V(:,1)<0&V(:,2)>=0);
tmpTidxs = sortByCos(vectors,condFunc,'ascend');
triIdsSort(num+1: num+length(tmpTidxs))=triIds(tmpTidxs);
num = num + length(tmpTidxs);
% 1st quatrant
condFunc = @(V)(V(:,1)>=0&V(:,2)>0);
tmpTidxs = sortByCos(vectors,condFunc,'ascend');
triIdsSort(num+1: num+length(tmpTidxs))=triIds(tmpTidxs);
end

