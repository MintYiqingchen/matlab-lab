function [ W,b,cost] = logistic_train( X, Y, lr, epoch, report, l1, decay)
[m,n]=size(X);
W = zeros(n,1); %randn(n,1)./20;
b = 0;
sigmoid = @(data)1./(1+exp(-data));

Yp=Y(Y==1); Yn=Y(Y==0);
Xp=X(Y==1,:); Xn=X(Y==0,:);
X_tmp=[Xp;Xn];
Y_tmp=[Yp;Yn];

for i=1:epoch
    out = sigmoid(X_tmp*W+b);
    old_cost = binary_cross_entropy(out, Y_tmp);
    
    % === calculate gradient ===
    grads = zeros(n,1);
    tmp = Y_tmp.*(1-out)+out.*(1-Y_tmp);
    for j=1:n
        grads(j) = -sum(tmp.*X_tmp(:,j));
    end
    % l1 gradient
    l1_grad(W>=0) = 1;
    l1_grad(W<0) = -1;
    
    % === update ===
    if mod(i,decay)==0
        lr=lr*0.1;
    end
    
    W=W-lr*(grads+l1*l1_grad');
    b=b-lr*sum(tmp); 
    
    % evaluate
    if mod(i,report)==0
        fprintf('[Epoch %d]: ',i);
        [TP,TN,FP,~]=evaluation_result(out,Y_tmp, 0.5);
        fprintf('precision: %f\trecall: %f\t',TP/(TP+FP), TP/length(Yp));
        fprintf('specificity: %f\taccuracy: %f\t',TN/length(Yn), (TP+TN)/m);
        fprintf('loss: %f\n',old_cost);
    end
end
cost = binary_cross_entropy(sigmoid(X*W+b),Y);
end

