function [ unitM,rightV ] = getTriUnitStiff( p_i, p_j, p_k, func )
% p_i, p_j,p_k are anticlockwise point
P=cat(1,p_i,p_j,p_k);
A=cat(2,[1;1;1],P);
S_mu=0.5*det(A);
unitM=zeros(3);
rightV=zeros(3,1);
for i=1:3
    tmp_p2=P(mod(i,3)+1,:);tmp_p3=P(mod(i+1,3)+1,:);
    ai=tmp_p2(1)*tmp_p3(2)-tmp_p3(1)*tmp_p2(2);
    bi=tmp_p2(2)-tmp_p3(2);
    ci=tmp_p3(1)-tmp_p2(1);
    for j=i:3
        tmp_p2=P(mod(j,3)+1,:);tmp_p3=P(mod(j+1,3)+1,:);
        bj=tmp_p2(2)-tmp_p3(2);
        cj=tmp_p3(1)-tmp_p2(1);
        unitM(i,j)=bi*bj+ci*cj;
        unitM(j,i)=unitM(i,j);
    end
    tmp_func=@(x,y)((ai + bi.*x + ci.*y).*func(x,y));
    rightV(i)=getTriIntegral(tmp_func, P(i,:), P(mod(i,3)+1,:), P(mod(i+1,3)+1,:) )./(2.*S_mu);
end
unitM=unitM./(4.*S_mu);
end

