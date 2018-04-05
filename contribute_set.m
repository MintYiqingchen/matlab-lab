function [ x_star,lambda_star ] = contribute_set( G,h,Agt, bgt,x0,epsilon,varargin)
%�����ü����������ι滮
%   Agt������ʽԼ������ Aeq����ʽԼ������,ת����ʽ,дΪAx>=b x0:��ʼ���е�
%   bgt��beq ������
%   todo����ʱ�俼��һ�£������ʽԼ����������
Display=0;
if ~isempty(varargin)
    Display=1;
    f = @(x)(0.5*x'*G*x+h'*x);
end
k=0;
[n,~]=size(Agt);
act_bm = ones(1,n); % ��¼��ǰ�����ü�
% ѡ�������ü�������A'�����ȵ�Ҫ���������ü�Ak ����>=����
xk=x0; inact_row = Agt*xk-bgt>epsilon;
act_bm(inact_row)=0;
while(k<1000)
    fprintf('������%d�� ',k);
    % ���������Լ������ⷽ��
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
       % �ж��Ƿ����е�ǰ����ʽԼ��Ak������
       [minl, idx]=min(lbdk);
       if(minl<0)
           % ɾ��Լ��
           act_bm(act_row(idx))=0;
           fprintf('delete constriant %d\n',act_row(idx));
       else
           break
       end
    else
        % �ҳ��ǻ���Լ������ ai'*dk<0
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
        assert(isempty(find(Agt*xk-bgt<-epsilon,1)),'�����Υ��Լ��');
        % ���������ü�
        act_row = abs(Agt*xk-bgt)<epsilon;
        act_bm(act_row)=1;
    end
    k=k+1;
end
% ����lambda_star
display(k, '��������');
x_star = xk;
lambda_star = Agt'\(G*x_star+h);
end

