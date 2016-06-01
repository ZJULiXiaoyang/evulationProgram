%%%R1-2.txt means transformation matrix from 2 coordinate system to
%%%1coordinate system
function [R,T]=loadRTMatrix(path,num1,num2,method)
switch method
    case 1%%% plane transfformation and use the homography matrix instead of RT matrix
        R=[1,0,0;0,1,0;0,0,1];
        T=[0,0,0];
    case 2%%% select the first image as the reference image
        RFile=strcat(path,'/R',num2str(1),'-',num2str(num2),'.txt');%%%viewChange
        TFile=strcat(path,'/T',num2str(1),'-',num2str(num2),'.txt');
        R=load(RFile);
        T=load(TFile);
    case 3%%%select the num1 image as  the reference image
        RFile1=strcat(path,'/R',num2str(1),'-',num2str(num1),'.txt');
        RFile2=strcat(path,'/R',num2str(1),'-',num2str(num2),'.txt');
        TFile1=strcat(path,'/T',num2str(1),'-',num2str(num1),'.txt');
        TFile2=strcat(path,'/T',num2str(1),'-',num2str(num2),'.txt');
        R1=load(RFile1);
        R2=load(RFile2);
        T1=load(TFile1);
        T2=load(TFile2);
        R=inv(R1)*R2;
        T=(inv(R1)*(T2-T1));
end
end