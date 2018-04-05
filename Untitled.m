function [ x_star, fval ] = myfminsearch( func,x,varargin )
%func:优化目标函数，x：起始点，varargin：变量参数
%   
ip=InputParser;
ip.addParameter('Tolerance',1e-6);
ip.addParameter('Algorithm','BFGS');
parse(ip, varargin);
if ip.Results.Algorithm == 'BFGS'
    display('using BFGS algorithm');
end

end

