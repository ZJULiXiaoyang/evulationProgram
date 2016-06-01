function [ xCh, yCh, zCh, kinect_map] = generate_xyz( kinect_depth )    %%将kinect数据转换成世界坐标系下的x,y,z坐标
% generate_xyz(kinect_depth) Given the Kinect depth map as input it
% calculates the X,Y,Z coordinate maps, along with the kinect_map
% indicating positions of non NaN values in the depth map.

% kinect_map = ~isnan(kinect_depth);     %%标记处没有深度损失的
kinect_map = kinect_depth&1;     %%标记处没有深度损失的（20150502）
% imshow(kinect_map);

kinect_depth=double(kinect_depth);
fx_d=1.11304347826087e+00;%640/focal=575
fy_d=8.347826086956522e-01; %480/focal=575
cx_d=0.5;cy_d=0.5;xRes=640.;yRes=480.;

[uMap,vMap]=meshgrid(1:xRes,1:yRes);   %%计算坐标
uMap = (uMap ./ xRes) - cx_d;
vMap = cy_d - (vMap ./ yRes);

zCh = kinect_depth/1000;   %%详细见kinect slam数据集下的参数设置和求取方法
xCh = uMap .* zCh .* fx_d;
yCh = vMap .* zCh .* fy_d;
end

