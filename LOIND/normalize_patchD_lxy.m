%%%This function is mainly to resize the patch to  a common size 41*41
%%%based on bilinear
%%%INPUT
%%%normal---the normal map corresponding to the depth map
%%%x,y---the coordinate of the keypoint
%%%raduis---the raduis of the patch to be described 
%%%scale---the scale of the patch to be described
%%%OUTPUT
%%%patch_normal---the normalized normal patch 
function [patch_normal]=normalize_patchD_lxy(normal,x,y,radius,scale)
patchsize=2*radius+1;
tmp_patch_normal=zeros(patchsize,patchsize,3);
patch_normal=zeros(41,41,3);
[height,width,~]=size(normal);

for i=-radius:radius  
    for j=-radius:radius     
        if  int32(x)+j>0 && int32(x)+j<width && int32(y)+i>0 && int32(y)+i<height
            tmp_patch_normal(radius+1+i,radius+1+j,1)= normal(int32(y)+i,int32(x)+j,1);
            tmp_patch_normal(radius+1+i,radius+1+j,2)= normal(int32(y)+i,int32(x)+j,2);
            tmp_patch_normal(radius+1+i,radius+1+j,3)= normal(int32(y)+i,int32(x)+j,3);
        end;        
    end
end
    patch_normal(:,:,1)=reshape_lxy( tmp_patch_normal(:,:,1),scale);
    patch_normal(:,:,2)=reshape_lxy( tmp_patch_normal(:,:,2),scale);
    patch_normal(:,:,3)=reshape_lxy( tmp_patch_normal(:,:,3),scale);
end