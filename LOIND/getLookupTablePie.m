function [mask angs] = getLookupTablePie(r, display)   %%�ֿ���

mask = zeros(2*r+1, 2*r+1);
angs = zeros(2*r+1, 2*r+1);
for i = 0 : r
    for j = -r : r  %%ѭ������ÿ����ĽǶ�ֵ�����ݽǶ�ֵ���
        rad = sqrt(j^2+i^2); %%���������ĵ��λ��
        if rad > r
            continue;  %%�ų�Բ��ĵ�
        end;
        mask(i+r+1,j+r+1) = 1;
        mask(-i+r+1,j+r+1) = 1;

        if j ~= 0 
            theta = atan(i/j);   %%����Ƕ�
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
        angs(-i+r+1,j+r+1) = 2*pi+theta;  %%���ýǶȴ��ڸ�ֵ
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