function [ keypoint,descriptor ] = LOIND( rgbImage,depthImage,normals,pcloud,kinect_map )

img_gray=rgb2gray(rgbImage);
img_gray=imadjust(img_gray);
I=single(img_gray);
[feature,~,info]=vl_covdet(I,'Method','MultiscaleHarris','PeakThreshold',1000,'EdgeThreshold',10);%%detecting feature

npies=8;%%%the spatial blocks
nbins=8;%%%the grayscale blocks
dnbins=2;%%%the normal blocks
gaussian = fspecial('gaussian',5,1);
GrayImage=filter2(gaussian,img_gray);%%conduct gaussian blur on the grayscale image

[featurePoint,point_num] = loadFeatures_lxy( feature,depthImage);
j=1;
[ mask,~ ] = LookupTable();  %% serching the table to get the mask efficient(PS: save time)
flag_xy=true;
for i=1:point_num            %%calculate the descriptors looping
    point=featurePoint(i);
    radius=round(point.r);   %%calculate the initial patch radius based on empirical formula
    [patch_pcloud,interestpoint]=normalize_patchP_lxy(pcloud,kinect_map,point.x,point.y,radius);%%%%get the patch of pointcloud，but the patch is not normalized
    flag=(size(patch_pcloud,1)>=2*radius^2)&(interestpoint~=[0,0,0]);%%%the point number of the patch is enough&&the depth of the interest point is not missed
    if flag
        radius = scale_estimation2(patch_pcloud,interestpoint,radius);
        point.r=radius;%%%update the scale radius of the patch
        patch_rgb= normalize_patch_lxy(GrayImage,point.x,point.y,radius,point.scale);%%%get the patch of depth image，and normalize the patch
        patch_normal=normalize_patchD_lxy(normals,point.x,point.y,radius,point.scale);%%%get the patch of normals��and normalize the patch
        [patch_pcloud,interestpoint]=normalize_patchP_lxy(pcloud,kinect_map,point.x,point.y,radius);%%%%get the patch of pointcloud using the new scale radius
        if flag_xy
%             normal = fitNormal(patch_pcloud, interestpoint,false);%%%plane fitting based on the patch��get the normal of the plane
            
            normal= getOrientation( patch_pcloud );
            [ u,v,orentition] = generate_uv( normal,interestpoint,point.x,point.y,480,640);%%%mapping the normal to the CCD to get the dominant orientation
            point.orientation=orentition;
            result_num=ceil(orentition*8/(2*pi));
            if result_num==0
                result_num=1;
            end
            pieindex= pieindex_table( result_num );
        else
            [point.orientation,result_num]=getorentation_lxy(patch_normal,npies,mask,8);
            pieindex= pieindex_table( result_num );
        end
        
        
        [descriptor, indictor] = getRGBDescriptor_lxy(41,patch_rgb,mask, pieindex, npies, nbins,dnbins,patch_normal);%%%calculate the descriptor
        point.descriptor=descriptor;
        point.orientation=point.orientation;
        
        if(indictor)
            feature_LOIND(j)=point;   %%mark the interest point which depth is not missed
            j=j+1;
        end
    end
end

num=size(feature_LOIND,2);
for i=1:num
   keypoint(1,i)=feature_LOIND(i).x; 
   keypoint(2,i)=feature_LOIND(i).y;
   keypoint(3,i)=feature_LOIND(i).r;
   descriptor(:,i)=feature_LOIND(i).descriptor(:);
end
end

