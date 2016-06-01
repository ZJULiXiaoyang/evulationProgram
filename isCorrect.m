%%%result=0 ->falseMatch 
%%%result=1 ->correctMatch
%%%result=2 ->DepthMissed 
function [result]=isCorrect(point1,point2,depthImage1,depthImage2,R,T)

CX=320;
CY=240;
focal=570.5;

u1=ceil(point1(1));
v1=ceil(point1(2));
z1=double(depthImage1(v1,u1))/1000;
if z1==0
    result=2;
    return
end
x1=(u1-CX)*z1/focal;
y1=(v1-CY)*z1/focal;

u2=ceil(point2(1));
v2=ceil(point2(2));
z2=double(depthImage2(v2,u2))/1000;
if z2==0
    result=2;
    return
end
x2=(u2-CX)*z2/focal;
y2=(v2-CY)*z2/focal;
x21=R(1,1)*x2+R(1,2)*y2+R(1,3)*z2+T(1);
y21=R(2,1)*x2+R(2,2)*y2+R(2,3)*z2+T(2);
z21=R(3,1)*x2+R(3,2)*y2+R(3,3)*z2+T(3);
u21=x21*focal/z21+CX;
v21=y21*focal/z21+CY;

distance=[x1-x21,y1-y21,z1-z21];
% distance =[u1-u21,v1-v21];

if norm(distance)<0.2
    result=1;
else
    result=0;
end
end

