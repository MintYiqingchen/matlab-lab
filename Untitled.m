function [ x_star, fval ] = myfminsearch( func,x,varargin )
%func:�Ż�Ŀ�꺯����x����ʼ�㣬varargin����������
%   
ip=InputParser;
ip.addParameter('Tolerance',1e-6);
ip.addParameter('Algorithm','BFGS');
parse(ip, varargin);
if ip.Results.Algorithm == 'BFGS'
    display('using BFGS algorithm');
end

end

