function err = binary_classification_error( preds, Y )
preds(preds<0.5)=0;
preds(preds>=0.5)=1;
correct = sum(preds==Y);
err = 1-correct./length(Y);
end

