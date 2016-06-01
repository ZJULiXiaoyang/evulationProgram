function [keypoint descriptor]=SIFTDescriptor(rgbImage)
    grayImage=rgb2gray(rgbImage);
    Ig=single(grayImage);
    [point_info,descriptor]=vl_sift(Ig);
    keypoint=point_info(1:2,:);    
end