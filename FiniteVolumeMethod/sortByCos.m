function idx = sortByCos(vectors,condFunc, direction)
condition = condFunc(vectors);
quatrant = vectors(condition,:);
idx = find(condition);

innerdot = quatrant*[1;0];
norms = sqrt(quatrant(:,1).^2+quatrant(:,2).^2);
[coss, I] = sort(innerdot./norms, direction);
idx = idx(I); % 注意这里返回的是与vector行数对应的索引，不是id
end

