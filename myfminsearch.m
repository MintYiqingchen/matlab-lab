function [ x_star, fval ] = myfminsearch( func,grad, x,varargin )
%func:优化目标函数，x：起始点，varargin：变量参数
%   
ip=inputParser;
ip.addParameter('Tolerance',1e-4);
ip.addParameter('Algorithm','BFGS');
ip.addParameter('MaxIteration',200*length(x));
parse(ip, varargin{:});
if ip.Results.Algorithm == 'BFGS'
    display('using BFGS algorithm');
    [x_star, fval] = bfgs(func,grad,x,ip.Results.Tolerance,ip.Results.MaxIteration);
end

end

