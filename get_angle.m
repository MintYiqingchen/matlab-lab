function an = get_angle(nd)
[temp, s] = size(nd);
an = [1:s];
for d = 1:s
if (nd(d)) < 0
    an(d) = -1;
else
syms x y
q1 = 64 * x^2 + 9 * y^2 - 14400 == 0;
q2 = (2880 * x - 14400) ^ 2 - nd(d)^2 * (4096 * x^2 + 81 * y^2) == 0;
a = solve(q1, q2);
x = double(a.x);
y = double(a.y);
if d < 61 || d > 150
    k = min(-64 * x./(9 * y));
else
    k = max(- 64 * x ./ (9 * y));
end
k = -1 / k;
an(d) = atan(k) * 180 / pi;
if d > 61
    an(d) = an(d) + 180;
end
an(d) = an(d) - 90;
end
an(13:61) = linspace(an(13), 0, 49);
an(61:109) = linspace(0, an(109), 49);
end
end