function [ data, mu, stds ] = normalize( X )
% a row is a sample
[m,n]=size(X);
data=zeros(m,n);
mu = mean(X,1);
stds = std(X,1);
for i=1:n
    data(:,i)=(X(:,i)-mu(i))./stds(i);
end

