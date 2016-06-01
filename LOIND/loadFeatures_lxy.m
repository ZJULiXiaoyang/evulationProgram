%%% This function is mainly to add the scale information to the keypoints
%%%INPUT
%%%feature ---the information of interesting points
%%%DepthImage ---the depth image
%%%OUTPUT
%%%featurePoint --- a struct of the interest point
%%%point_num---the number of the interesting point
function [ featurePoint,point_num] = loadFeatures_lxy( feature,DepthImage)
DepthImage=double(DepthImage);
point_num=size(feature,2);
Dscale=0.001;%%%the scale of the RGB-D camera(mostly it is 1000 or 5000 which depent on the data)
for i=1:point_num
    featurePoint(i).x=feature(1,i);
    featurePoint(i).y=feature(2,i);
    u=round(featurePoint(i).x);
    v=round(featurePoint(i).y);
    distance=DepthImage(v,u)*Dscale;  %%the distance 
    featurePoint(i).scale=max(0.2,(3.4-0.4*max(1,distance))/3);   %%empirical equation from the article BRAND
    featurePoint(i).r=20*featurePoint(i).scale; %%the radius of the patch to be described
end

