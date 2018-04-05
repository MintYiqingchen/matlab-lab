function [r, g] = watson( x )
% watson 函数: x 为 n维向量
% r 为前向传播结果
% g 为反向传播结果
  r = zeros(1,31)';
  g = zeros(1,length(x))';
  % forward
  % 求r_i 1<=i<=29
  for i=1:29
      v_i=arrayfun(@(j)((i/29)^j),1:length(x))';
      u_i=arrayfun(@(j)((j-1)*(i/29)^(j-2)),1:length(x))';
      r(i) = (u_i'*x)-(v_i'*x)^2-1;
      g = g + 2*r(i).*(2*(v_i'*x).*v_i+u_i);
  end
  r(30)=x(1);
  r(31)=x(2)-x(1)^2-1;
  g = g+2*r(30).*[1;zeros(length(x)-1,1)]+2*r(31).*[-2*x(1);1;zeros(length(x)-2,1)];
  r = sum(r.^2);
end

