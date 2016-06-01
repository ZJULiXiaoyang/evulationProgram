close all,clear all,clc;
addpath(genpath(pwd));
path='/home/hali/lixiaoyang/dataset/ManipulatorsDataset';
num1=1;%%%reference image
index=1;
for k=1:1:4
    num2=k;
    sceneName='mixture/';
    type='illum/';
    method=1;
    flagShowCurve=true;
    illumTypes={'cube','cubeRoot','square','squareRoot'};
    illumType=illumTypes(k);
    illumType=illumType{1};
    filePath=strcat(path,'/',sceneName,type);
    rgb_file1=strcat(filePath,'rgb_',num2str(num1),'.png');
    rgb_file2=strcat(filePath,'rgb_',num2str(num1),'_',illumType,'.png');
    depth_file1=strcat(filePath,'depth_',num2str(num1),'.png');
    depth_file2=strcat(filePath,'depth_',num2str(num1),'.png');
    
    % [ R,T ] = getRTMatrix( rgb_file1,depth_file1,rgb_file2,depth_file2,2 );
    [R,T]=loadRTMatrix(filePath,num1,num2,method);
    
    
    rgbImage1=imread(rgb_file1);
    rgbImage2=imread(rgb_file2);
    depthImage1=imread(depth_file1);
    depthImage2=imread(depth_file2);
    
    [siftkeypoint1,siftdescriptor1]=SIFTDescriptor(rgbImage1);
    [siftkeypoint2,siftdescriptor2]=SIFTDescriptor(rgbImage2);
    %     homography_lxy( siftdescriptor1,siftdescriptor2, 1,siftkeypoint1,siftkeypoint2);
    [unprecision1,recall1,inlierRate1]=domatch(siftkeypoint1,siftkeypoint2,siftdescriptor1,siftdescriptor2,0.7,rgbImage1,rgbImage2,depthImage1,depthImage2,R,T,flagShowCurve,method,1,num1,num2,'SIFT');
    
    
    [CSHOTkeypoint1,CSHOTdescriptor1]=CSHOT_xy(rgb_file1,depth_file1);
    [CSHOTkeypoint2,CSHOTdescriptor2]=CSHOT_xy(rgb_file2,depth_file2);
    % homography_lxy( CSHOTdescriptor1,CSHOTdescriptor2, 1,CSHOTkeypoint1,CSHOTkeypoint2);
    [unprecision2,recall2,inlierRate2]=domatch(CSHOTkeypoint1,CSHOTkeypoint2,CSHOTdescriptor1,CSHOTdescriptor2,0.7,rgbImage1,rgbImage2,depthImage1,depthImage2,R,T,flagShowCurve,method,2,num1,num2,'CSHOT');
    
    
    
    [ normals1,pcloud1,kinect_map1] = normalaverageestimation_lxy( depthImage1);
    [ normals2,pcloud2,kinect_map2] = normalaverageestimation_lxy( depthImage2);
    [LDkeypoint1,LDdescriptor1]=LOIND_fgh(rgbImage1,depthImage1,normals1,pcloud1,kinect_map1);
    [LDkeypoint2,LDdescriptor2]=LOIND_fgh(rgbImage2,depthImage2,normals2,pcloud2,kinect_map2);
    [unprecision3,recall3,inlierRate3]=domatch(LDkeypoint1,LDkeypoint2,LDdescriptor1,LDdescriptor2,0.7,rgbImage1,rgbImage2,depthImage1,depthImage2,R,T,flagShowCurve,method,3,num1,num2,'LOIND');
    
    [LOINDkeypoint1,LOINDdescriptor1]=LOIND(rgbImage1,depthImage1,normals1,pcloud1,kinect_map1);
    [LOINDkeypoint2,LOINDdescriptor2]=LOIND(rgbImage2,depthImage2,normals2,pcloud2,kinect_map2);
    [unprecision4,recall4,inlierRate4]=domatch(LOINDkeypoint1,LOINDkeypoint2,LOINDdescriptor1,LOINDdescriptor2,0.7,rgbImage1,rgbImage2,depthImage1,depthImage2,R,T,flagShowCurve,method,4,num1,num2,'LOIND+');
    
    inlierRates1(index)=inlierRate1;
    inlierRates2(index)=inlierRate2;
    inlierRates3(index)=inlierRate3;
    inlierRates4(index)=inlierRate4;
    index=index+1;
    
    plotflag=1;
    if plotflag
        figure(100+k);
        plot(unprecision1(1:50),recall1(1:50),'-or');
        hold on;
        plot(unprecision2(1:50),recall2(1:50),'-+g');
        plot(unprecision3(1:50),recall3(1:50),'-*b');
        plot(unprecision4(1:50),recall4(1:50),'-pc');
        legend('SIFT','CSHOT','LOIND','RISAS');
        recall=[recall1;recall2;recall3;recall4];
        maxRecall=min(max(max(recall))+0.2,1);
        xlim([0,1]);
        ylim([0,maxRecall]);
        xlabel('1-Precision');
        ylabel('Recall');
        grid on;
    end
end
% save('SIFTRotateInlierRates','inlierRates1');
% save('CSHOTRotateInlierRates','inlierRates2');
% save('LOINDRotateInlierRates','inlierRates3');
% save('RISASRotateInlierRates','inlierRates4');


