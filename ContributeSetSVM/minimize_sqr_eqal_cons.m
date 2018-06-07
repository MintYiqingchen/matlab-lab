function [ x_star, lambda_star ] = minimize_sqr_eqal_cons( G, h, A, b )
%求解 等式约束二次规划 最小值
%   input: G-Hessen Matrix; A:constriant Matrix transpose
%   output: x_star local or global optimized point
if ~isempty(b)
    At = A';
    [Q, R] = qr(At);
    [n, m] = size(At);
    Q1 = Q(:,1:m); Q2 = Q(:,m+1:n); R = R(1:m,:);
    Y = Q1/R';
    [T,p] = chol(Q2'*G*Q2);
    if p~=0
        fprintf('Q2T*G*Q2 is not positive Matrix\n');
    end
        x_z = (Q2'*G*Q2)\(-Q2'*(h+G*Y*b));
        x_star = Y*b+Q2*x_z;
        lambda_star = Y'*(G*x_star+h);
        assert(norm(A*x_star-b)<eps*10);
else
    x_star = pinv(G)\-h;
    lambda_star = 0;
end
end


