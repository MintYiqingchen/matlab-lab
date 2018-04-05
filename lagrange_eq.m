function [ x_star, lambda_star ] = lagrange_eq( G,h,A,b )
%�������շ������kkt����
if ~isempty(b)
    w = G\-h;
    x_star = A\b;
    lambda_star = A'\(G*x_star+h);
else
    x_star = G\-h;
    lambda_star = 0;
end
end

