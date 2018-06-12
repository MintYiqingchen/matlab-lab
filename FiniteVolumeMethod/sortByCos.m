function idx = sortByCos(vectors,condFunc, direction)
condition = condFunc(vectors);
quatrant = vectors(condition,:);
idx = find(condition);

innerdot = quatrant*[1;0];
norms = sqrt(quatrant(:,1).^2+quatrant(:,2).^2);
[coss, I] = sort(innerdot./norms, direction);
idx = idx(I); % ע�����ﷵ�ص�����vector������Ӧ������������id
end

