function [ w,b,alpha ] = train_svm( data, label, penalty, varargin)
% ѵ��֧����������ʹ�����Ժ˺���
%   penalty�������ͷ�����
opts = optimoptions('quadprog',...
    'Algorithm','active-set','Display','iter','MaxIter',1000);
h = -ones(length(label),1);
% ���ɾ���G,���ھ�������ֱ�ӷֽ�ΪLL��
[n,m]=size(data);
L = data.*repelem(label,1,m);
G = L*L';
f = @(x)(0.5*x'*G*x+h'*x);
% ����Լ������Agt, Լ���� b
Agt = vertcat(eye(n), -eye(n));
bgt1 = zeros(n,1);
bgt2 = -repelem(penalty,n,1);
bgt = vertcat(bgt1,bgt2);
alpha0 = repelem(penalty,n)';
alpha = contribute_set(G,h,Agt,bgt,alpha0,1e-12);
display(f(alpha),'object value:');
idx = find(alpha~=0,1); % Ѱ��֧������
% ���� w,b
w = data'*(alpha.*label);
b = label(idx)-w'*data(idx,:)';

end



