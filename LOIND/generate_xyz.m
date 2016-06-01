function [ xCh, yCh, zCh, kinect_map] = generate_xyz( kinect_depth )    %%��kinect����ת������������ϵ�µ�x,y,z����
% generate_xyz(kinect_depth) Given the Kinect depth map as input it
% calculates the X,Y,Z coordinate maps, along with the kinect_map
% indicating positions of non NaN values in the depth map.

% kinect_map = ~isnan(kinect_depth);     %%��Ǵ�û�������ʧ��
kinect_map = kinect_depth&1;     %%��Ǵ�û�������ʧ�ģ�20150502��
% imshow(kinect_map);

kinect_depth=double(kinect_depth);
fx_d=1.11304347826087e+00;%640/focal=575
fy_d=8.347826086956522e-01; %480/focal=575
cx_d=0.5;cy_d=0.5;xRes=640.;yRes=480.;

[uMap,vMap]=meshgrid(1:xRes,1:yRes);   %%��������
uMap = (uMap ./ xRes) - cx_d;
vMap = cy_d - (vMap ./ yRes);

zCh = kinect_depth/1000;   %%��ϸ��kinect slam���ݼ��µĲ������ú���ȡ����
xCh = uMap .* zCh .* fx_d;
yCh = vMap .* zCh .* fy_d;
end

