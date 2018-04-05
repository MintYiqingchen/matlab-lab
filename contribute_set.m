function [ x_star,lambda_star ] = contribute_set( G,h,Agt, bgt,x0,epsilon,varargin)
%起作用集方法求解二次规划
%   Agt：不等式约束矩阵 Aeq：等式约束矩阵,转置形式,写为Ax>=b x0:初始可行点
%   bgt、beq 列向量
%   todo：有时间考虑一下，传入等式约束矩阵的情况
Display=0;
if ~isempty(varargin)
    Display=1;
    f = @(x)(0.5*x'*G*x+h'*x);
end
k=0;
[n,~]=size(Agt);
act_bm = ones(1,n); % 记录当前起作用集
% 选定起作用集，由于A'列满秩的要求，最终作用集Ak 列数>=行数
xk=x0; inact_row = Agt*xk-bgt>epsilon;
act_bm(inact_row)=0;
while(k<1000)
    fprintf('迭代第%d次 ',k);
    % 组合起作用约束，求解方向
    act_row = find(act_bm==1);
    Ak = Agt(act_row,:);
    [dk, lbdk] = minimize_sqr_eqal_cons(G,G*xk+h,Ak,zeros(length(act_row),1));
    % verbose
        if Display
            display(dk');
            display(xk');
            display(Ak);
            display(lbdk','lambda_k');
            display(f(xk),'fk');
        end
    if norm(dk)<epsilon
       %fprintf('enter dk=0\n');
       % 判断是否所有当前不等式约束Ak起作用
       [minl, idx]=min(lbdk);
       if(minl<0)
           % 删除约束
           act_bm(act_row(idx))=0;
           fprintf('delete constriant %d\n',act_row(idx));
       else
           break
       end
    else
        % 找出非积极约束，且 ai'*dk<0
        inact_row = intersect(find(Agt*dk<-epsilon),find(act_bm==0));
        b_inact = bgt(inact_row); A_inact=Agt(inact_row,:);

        alphak = min(1,min((b_inact-A_inact*xk)./(A_inact*dk)));
        if isempty(alphak)
            alphak=1;
        end
        if alphak < epsilon
            dk = dk./norm(dk);
            alphak = min(1,min((b_inact-A_inact*xk)./(A_inact*dk)));
        end
        if alphak<=0
            fprintf('===========\n');
            break;
        end
        xk = xk + alphak.* dk; 
        assert(isempty(find(Agt*xk-bgt<-epsilon,1)),'求解结果违反约束');
        % 更新起作用集
        act_row = abs(Agt*xk-bgt)<epsilon;
        act_bm(act_row)=1;
    end
    k=k+1;
end
% 计算lambda_star
display(k, '迭代次数');
x_star = xk;
lambda_star = Agt'\(G*x_star+h);
end

