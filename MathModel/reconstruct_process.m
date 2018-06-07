function an = reconstruct_process(r_x, r_y, data, angles, k, b, scale)
%RECONSTRUCT_PROCESS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
recons = tomo_reconstruction_fbp(data, angles, true);
recons = imresize(recons, scale);
[sx, sy] = size(recons);
recons = recons((sx / 2 + r_y - 100): (sx / 2 + r_y), (sy / 2 - r_x): (sy / 2 - r_x + 100));
an = recons * k + b;
[sx, sy] = size(an);
an = imresize(an, 256 / sx);

end

