%%%method=1----PnP
%%%method=2---SVD
function [ R,T ] = getRTMatrix( rgbImage1,depthImage1,rgbImage2,depthImage2,method )

commond=['./getRTMatrix ',rgbImage1,' ',depthImage1,' ',rgbImage2,' ',depthImage2,' ',num2str(method)];
system(commond);
load('R.txt');
load('T.txt');
R=R;
T=T;
end

