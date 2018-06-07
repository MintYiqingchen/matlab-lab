function d = lmNewton( Hess, x, g )
% lm��������ţ�ٷ���
v_k=0.2;
I = eye(length(x));
H = Hess(x);
while(1)
    B = H+v_k*I;
    if(det(B)<10e-5)
        v_k=2*v_k
    else
        d = -B\g;
        break;
    end
end

end

