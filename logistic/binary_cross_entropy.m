function loss = binary_cross_entropy( preds, Y )
idx_0 = Y==0;
idx_1 = Y==1;
preds_0 = preds(idx_0);
preds_1 = preds(idx_1);
eps=1e-6;
loss = mean(log(preds_1+eps))+mean(log(1-preds_0+eps));
loss = -loss;
end

