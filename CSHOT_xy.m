function [keyPoint,descriptor]=CSHOT_xy(rgbImageFile,depthImageFile)

keypointFile='./cshot/keypoint.txt';
descriptorFile='CSHOT.txt';
rgbImage=imread(rgbImageFile);

img_gray=rgb2gray(rgbImage);
img_gray=imadjust(img_gray);
I=single(img_gray);
[keyPoint,~,~]=vl_covdet(I,'Method','MultiscaleHarris','PeakThreshold',1000,'EdgeThreshold',10);

c=fopen(keypointFile,'w');
num=size(keyPoint,2);
fprintf(c,'%d\n',num);
for i=1:num
    fprintf(c,'%f ',keyPoint(1,i));
    fprintf(c,'%f\n',keyPoint(2,i));
end
fclose(c);
pwd
commond=['./cshot/CSHOT ',rgbImageFile,' ',depthImageFile,' ',keypointFile]
system(commond);
load(descriptorFile);
descriptor=CSHOT';

end