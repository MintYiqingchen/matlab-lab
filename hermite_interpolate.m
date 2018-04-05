function pp = hermite_interpolate(lo, hi, f1, f2, g1,g2)
%�����������β�ֵ�Ķ���ʽ
% f����ֵ��gһ�׵���ֵ
p11=[2./(hi-lo), 1-2*lo./(hi-lo)].*f1;
p12=[1./(lo-hi), -hi./(lo-hi)]; p12=conv(p12,p12);

p21=[2./(lo-hi), 1-2*hi./(lo-hi)].*f2;
p22=[1./(hi-lo), -lo./(hi-lo)]; p22=conv(p22,p22);

p31=[g1,-g1*lo]; p41=[g2, -g2*hi];

pp = conv(p11,p12)+conv(p21,p22)+ conv(p31,p12)+conv(p41, p22);
end

