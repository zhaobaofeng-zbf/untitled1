L = bwlabel(binary): %binary = 你贴出来的这个图
rect = zeros(size(binary));
rect(L==3) = 1; %图中矩形是第三块区域。
rect = repmat(rect,[1,1,3]);
rect(rect==1) = I(rect==1); % I = RGB图