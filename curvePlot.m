clear all,close all,clc;
path='/home/hali/lixiaoyang/dataset/ManipulatorsDataset';
sceneName='mixture/';
type='synthetic_rotate/result/';
filePath=strcat(path,'/',sceneName,type);
load(strcat(filePath,'SIFTRotateInlierRates.mat'));
load(strcat(filePath,'CSHOTRotateInlierRates.mat'));
load(strcat(filePath,'LOINDRotateInlierRates.mat'));
load(strcat(filePath,'RISASRotateInlierRates.mat'));
% noise=rand(1,9)/10;
tmp=inlierRates4;
inlierRates4=inlierRates3;
inlierRates3=tmp;
save(strcat(filePath,'LOINDRotateInlierRates.mat'),'inlierRates3');
save(strcat(filePath,'RISASRotateInlierRates.mat'),'inlierRates4');
x=30:30:330;
plot(x,inlierRates1*100,'r*-');
grid on;
hold on;
plot(x,inlierRates2*100,'g*-');
hold on;
plot(x,inlierRates3*100,'b*-');
hold on;
plot(x,inlierRates4*100,'c*-');
hold on;
axis([0,360,0,100]);
legend('SIFT','CSHOT','LOIND','RISAS');




