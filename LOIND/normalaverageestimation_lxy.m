%%%get the normal from the depth map
%%%INPUT
%%%DepthImage---the depth image
%%%OUTPUT
%%%normal---the normal corresponding to the depth image 
%%%pcloud--- the pointcloud corresponding to the depth image 
%%%kinect_map---the mask of the depth image.If the depth value is lost ,the
% corresponding value in the kinect_map is 0.


function [ normal,pcloud,kinect_map] = normalaverageestimation_lxy( DepthImage)
disp('calculating the normal.')
[pcloud, kinect_map] = depthToCloud(DepthImage);
tic;
normal = pcnormal(pcloud);
toc;
gaussian = fspecial('gaussian',5,1);
normal(:,:,1)= filter2(gaussian,normal(:,:,1));  %%smoothing the normal
normal(:,:,2)= filter2(gaussian,normal(:,:,2));
normal(:,:,3)= filter2(gaussian,normal(:,:,3));

disp('Get the normal.')
end

