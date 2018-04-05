function [ w,b,alpha ] = train_svm( data, label, penalty, varargin)
% 训练支持向量机，使用线性核函数
%   penalty：软间隔惩罚因子
opts = optimoptions('quadprog',...
    'Algorithm','active-set','Display','iter','MaxIter',1000);
h = -ones(length(label),1);
% 生成矩阵G,由于精度问题直接分解为LL’
[n,m]=size(data);
L = data.*repelem(label,1,m);
G = L*L';
f = @(x)(0.5*x'*G*x+h'*x);
% 生成约束矩阵Agt, 约束项 b
Agt = vertcat(eye(n), -eye(n));
bgt1 = zeros(n,1);
bgt2 = -repelem(penalty,n,1);
bgt = vertcat(bgt1,bgt2);
alpha0 = repelem(penalty,n)';
alpha = contribute_set(G,h,Agt,bgt,alpha0,1e-12);
display(f(alpha),'object value:');
idx = find(alpha~=0,1); % 寻找支持向量
% 计算 w,b
w = data'*(alpha.*label);
b = label(idx)-w'*data(idx,:)';

end



