%%%This function is mainly to resize the patch to  a common size 41*41
%%%based on bilinear
%%%INPUT
%%%GrayImage---the grayscale image
%%%x,y---the coordinate of the keypoint
%%%raduis---the raduis of the patch to be described 
%%%scale---the scale of the patch to be described
%%%OUTPUT
%%%patch---the normalized grayscale image patch 
function [ patch ] = normalize_patch_lxy(GrayImage,x,y,raduis,scale)
patchsize=2*raduis+1;
tmp_patch=zeros(patchsize);
patch=zeros(41,41);
[height,width]=size(GrayImage);

for i=-raduis:raduis   
    for j=-raduis:raduis     
        if  int32(x)+j>0 && int32(x)+j<width && int32(y)+i>0 && int32(y)+i<height
            tmp_patch(raduis+1+i,raduis+1+j)= GrayImage(int32(y)+i,int32(x)+j);
        end;        
    end
end
patch= reshape_lxy( tmp_patch,scale);
end

