function [mask angs] = getLookupTablePie(r, display)   %%分块标记

mask = zeros(2*r+1, 2*r+1);
angs = zeros(2*r+1, 2*r+1);
for i = 0 : r
    for j = -r : r  %%循环计算每个点的角度值，根据角度值标记
        rad = sqrt(j^2+i^2); %%计算离中心点的位置
        if rad > r
            continue;  %%排除圆外的点
        end;
        mask(i+r+1,j+r+1) = 1;
        mask(-i+r+1,j+r+1) = 1;

        if j ~= 0 
            theta = atan(i/j);   %%计算角度
        elseif j == 0 & i >= 0
            theta = pi/2;
        elseif j == 0 & i < 0
            theta = pi;
        else
            theta = pi;
        end;
        
        if i == 0 & j >= 0
            theta = 0;
        elseif i==0 & j <0
            theta = pi;
        end;
        if theta < 0;
            theta = pi + theta;
        end;
        angs(-i+r+1,j+r+1) = 2*pi+theta;  %%不让角度存在负值
        angs(i+r+1, j+r+1) = 4*pi-theta;
    end;
end;

if display 
    figure;imagesc(angs); colormap(gray);
end;

% %lkt = cell(npies,1);
% slice = 2*pi/npies;
% index = zeros(2*r+1, 2*r+1);
% tmp = ceil(angs/slice);
% for i = -r : r
%     for j = -r : r
%         if mask(i+r+1,j+r+1) == 0
%             continue;
%         end;
%         idx = tmp(i+r+1,j+r+1);%ceil(angs(i+r+1,j+r+1)/slice);
% %         idx = idx+4;
% %         if idx > 8
% %             idx = idx - 8 + 1;
% %         end;
%         index(i+r+1, j+r+1) = idx;%idx;
%       
%  %       lkt{idx,1} = [lkt{idx,1} [-i,j]'];
%     end;
% end;
% 
% if display
%     figure;imagesc(index);colormap(gray);
% end;