%%%This function is mainly to resize the patch to  a common size 41*41
%%%based on bilinear
function [ patch ] = reshape_lxy( patch,scale )
[height,width]=size(patch);
radius=(height-1)/2;
kernel=ceil(scale);
gaussian = fspecial('gaussian',5,kernel); 
if radius>20
    patch = filter2(gaussian,patch);
end
patch=imresize(patch,[41,41],'bilinear');
end

