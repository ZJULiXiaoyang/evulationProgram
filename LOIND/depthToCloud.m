
% depthToCloud.m - Convert depth image into 3D point cloud

% Input: 
% depth - the depth image
% topleft - the position of the top-left corner of depth in the original depth image. Assumes depth is uncropped if this is not provided
%
% Output:
% pcloud - the point cloud, where each channel is the x, y, and z euclidean coordinates respectively. Missing values are 0.
% kinect_map - the mask of the depth image.If the depth value is lost ,the
% corresponding value in the kinect_map is 0.
function [pcloud, kinect_map] = depthToCloud(depth, topleft)

if nargin < 2
    topleft = [1 1];
end

depth= double(depth);
depth(depth == 0) = 0;

% RGB-D camera constants
center = [320 240];
[imh, imw] = size(depth);
kinect_map = depth&1;
constant = 575;
MM_PER_M = 1000;

% convert depth image to 3d point clouds
pcloud = zeros(imh,imw,3);
xgrid = ones(imh,1)*(1:imw) + (topleft(1)-1) - center(1);
ygrid = (1:imh)'*ones(1,imw) + (topleft(2)-1) - center(2);
pcloud(:,:,1) = xgrid.*depth/constant/MM_PER_M;
pcloud(:,:,2) = ygrid.*depth/constant/MM_PER_M;
pcloud(:,:,3) = depth/MM_PER_M;

end

