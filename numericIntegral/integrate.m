%���û���������
f=@(x)(sin(x)./x);
%���ϸ�˹�����ʽ
%{
res=[];
[res(1),laster]=Gauss(f,0,1,2);
for n=2:8
    [res(n),err]=Gauss(f,0,1,2^n);
    %��������
    sprintf('��%d������ʱ:\n����Ϊ %.4f\n����Ϊ%.7f',n,log2(laster/err),res(n))
    laster=err;
end
%}
%n=4�Ŀ���˹��ʽ
[resNew,err]=newcets(f,0,1);
disp(resNew);
disp(err);
