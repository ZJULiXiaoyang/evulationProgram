function [ feature,featurePoint] = LOIND_fgh( RgbImageFile,DepthImageFile,featurefile,index)
disp('***************************');
disp('calculating the LOIND...');
npies=8;%%%the spatial blocks
nbins=8;%%%the grayscale blocks
dnbins=2;%%%the normal blocks
RgbImage=imread(RgbImageFile);
DepthImage=imread(DepthImageFile);
[height,width,~]=size(RgbImage);
gaussian = fspecial('gaussian',5,1);    %%% the setting of filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%calculate the normal
[ normals,normal_maskD,pcloud,kinect_map] = normalaverageestimation_lxy( DepthImage,DepthImageFile,index);
normals(:,:,1)= filter2(gaussian,normals(:,:,1));  %%smoothing the normal
normals(:,:,2)= filter2(gaussian,normals(:,:,2));
normals(:,:,3)= filter2(gaussian,normals(:,:,3));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [mainNormal]=getMainNormal(normals)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%the image preprocess


GrayImage=rgb2gray(RgbImage);
% GrayImage=imadjust(GrayImage);
GrayImage=double(GrayImage);
GrayImage=filter2(gaussian,GrayImage);
DepthImage=double(DepthImage);
DepthImage=filter2(gaussian,DepthImage);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[featurePoint,point_num] = loadFeatures_lxy( featurefile,DepthImage);
j=1;
[ mask,angs ] = LookupTable();  %% serching the table to get the mask efficient(PS: save time)
for i=1:point_num            %%calculate the descriptors looping
    point=featurePoint(i);
    radius=round(point.r);   %%calculate the initial patch radius based on empirical formula
    %     [mask angs] = getLookupTablePie(radius,0);  %%the patch is not normalized and calculate the mask
    [patch_pcloud,interestpoint]=normalize_patchP_lxy(pcloud,kinect_map,point.x,point.y,radius);%%%%get the patch of pointcloud��but the patch is not normalized
    flag=(size(patch_pcloud,1)>=2*radius^2)&(interestpoint~=[0,0,0]);%%%the point number of the patch is enough&&the depth of the interest point is not missed
    if flag
        %                 radius=ceil(scale_estimation( patch_pcloud,interestpoint,true ));%%%the scale estimation based on ellipsoid fitting
        %         point.r=radius;%%%update the scale radius of the patch
        
        patch_rgb= normalize_patch_lxy(GrayImage,point.x,point.y,radius,point.scale);%%%get the patch of depth image��and normalize the patch
        patch_normal=normalize_patchD_lxy(normals,point.x,point.y,radius,point.scale);%%%get the patch of normals��and normalize the patch       
        [patch_pcloud,interestpoint]=normalize_patchP_lxy(pcloud,kinect_map,point.x,point.y,radius);%%%%get the patch of pointcloud using the new scale radius
        
        %             pieindex=getpieindex_lxy(mask,20,npies,angs,point);     %%get the index of the roratated image blocks
        [point.orientation,result_num]=getorentation_lxy(patch_normal,npies,mask,8);
        pieindex= pieindex_table( result_num );
        [descriptor, indictor] = getRGBDescriptor_lxy(41,patch_rgb,mask, pieindex, npies, nbins,dnbins,patch_normal);%%%calculate the descriptor
        point.descriptor=descriptor;
        point.orientation=point.orientation;
        
        if(indictor)
            feature(j)=point;   %%mark the interest point which depth is not missed
            j=j+1;
        end
    end
end
disp('Get the LOIND.')
disp('***************************');
end

