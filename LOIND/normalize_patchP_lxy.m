%%%This function is mainly to get the pointcloud of the interesting patch
%%%INPUT
%%%pcloud---the pointcloud corresponding to the depth image
%%%kinect_map---the mask of the depth image 
%%%x,y---the coordinate of the keypoint
%%%raduis---the raduis of the patch to be described 
%%%OUTPUT
%%%patch_pcloud---the pointcloud of the interesting patch
%%%interestpoint--- the keypoint
function [patch_pcloud,interestpoint]=normalize_patchP_lxy(pcloud,kinect_map,x,y,radius)
patch_pcloud=[];
[height,width,~]=size(pcloud);
num=1;

for i=-radius:radius   
    for j=-radius:radius
        v=int32(y)+i;
        u=int32(x)+j;
        if  u>0 && u<width && v>0 && v<height&&kinect_map(v,u)~=0
            patch_pcloud(num,1)= pcloud(v,u,1);
            patch_pcloud(num,2)= pcloud(v,u,2);
            patch_pcloud(num,3)= pcloud(v,u,3);
            num=num+1;
        end;
    end
end
interestpoint(1,1)= pcloud(int32(y),int32(x),1);
interestpoint(1,2)= pcloud(int32(y),int32(x),2);
interestpoint(1,3)= pcloud(int32(y),int32(x),3);

end

